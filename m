Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313272AbSDDRRP>; Thu, 4 Apr 2002 12:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313271AbSDDRRG>; Thu, 4 Apr 2002 12:17:06 -0500
Received: from imladris.infradead.org ([194.205.184.45]:48913 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313270AbSDDRQ5>; Thu, 4 Apr 2002 12:16:57 -0500
Date: Thu, 4 Apr 2002 18:16:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020404181655.A29249@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204040747260.25330-100000@devserv.devel.redhat.com> <Pine.LNX.4.33.0204041625250.1089-100000@einstein.homenet> <20020404185510.D32431@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc-list trimmed, I guess everyone is on lkml anyway..]

On Thu, Apr 04, 2002 at 06:55:10PM +0200, Andrea Arcangeli wrote:
> further developement. The important thing is that we never include non
> GPL code in the mainline kernel and that the 99% of the code is under
> the GPL licence and that it can be intermixed freely (basically only
> modulo bsdcomp and a few other very exceptions in their own files with
> bold letters about the BSD thing).

Stuff like bsdcomp and the quota stuff are 2clause BSD now and thus fully
GPL-compatible.

