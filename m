Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132519AbRDDXRj>; Wed, 4 Apr 2001 19:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132520AbRDDXRa>; Wed, 4 Apr 2001 19:17:30 -0400
Received: from platan.vc.cvut.cz ([147.32.240.81]:32775 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S132519AbRDDXRN>; Wed, 4 Apr 2001 19:17:13 -0400
Message-ID: <3ACBAB4B.F6E19149@vc.cvut.cz>
Date: Wed, 04 Apr 2001 16:16:27 -0700
From: Petr Vandrovec <vandrove@vc.cvut.cz>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac28-4g i686)
X-Accept-Language: cz, cs, en
MIME-Version: 1.0
To: Stuart McFadden <stuartymcf@netgames-uk.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Underscore in rivafb
In-Reply-To: <200104042225.f34MPCv00980@Xerxes.buttmunch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart McFadden wrote:
> 
> Hi,
>    The flashing block in rivafb was annoying me, so here is a diff (against
> vanilla 2.4.3 ) of a quick hack in case anyone else was having the same problem.

Get a look at
drivers/video/matrox/matroxfb_misc:matroxfb_createcursorshape, and
its callers, matroxfb_*_createcursor. If you'll use
conp->vc_cursor_type, standard
escape sequences for disabling cursor and for shape selection will work
on
riva then...
							Petr Vandrovec
							vandrove@vc.cvut.cz
