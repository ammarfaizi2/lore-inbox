Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUGLS7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUGLS7T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 14:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUGLS7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 14:59:18 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:30183 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261724AbUGLS7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 14:59:03 -0400
Date: Mon, 12 Jul 2004 15:32:48 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
       dtor_core@ameritech.net, karim@opersys.com,
       linux-kernel@vger.kernel.org, celinux-dev@tree.celinuxforum.org,
       tpoynor@mvista.com
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Message-ID: <20040712153248.A3743@mail.kroptech.com>
References: <40EEF10F.1030404@am.sony.com> <200407102351.05059.dtor_core@ameritech.net> <40F0C8E8.2060908@opersys.com> <200407110019.14558.dtor_core@ameritech.net> <20040710222702.3718842e.akpm@osdl.org> <Pine.GSO.4.58.0407110945010.3013@waterleaf.sonytel.be> <20040711005156.1d6558dd.akpm@osdl.org> <20040711094128.A27649@mail.kroptech.com> <40F2DDFC.8010501@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40F2DDFC.8010501@am.sony.com>; from tim.bird@am.sony.com on Mon, Jul 12, 2004 at 11:52:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 11:52:44AM -0700, Tim Bird wrote:
> Adam Kropelin wrote:
> > Here's a patch. It places the relevant information on the same line as
> > bogomips and does so without encouraging anyone to fiddle with
> > loops_per_jiffy and screw up their kernel. 
> 
> The patch is missing the Kconfig piece.  Is the wording the
> same as from your earlier patch?

Andrew requested that the config option be removed, so there are no
longer any changes to Kconfig.

--Adam

