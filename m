Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269017AbTGJHlf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 03:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268992AbTGJHle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 03:41:34 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:25101 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269017AbTGJHjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 03:39:00 -0400
Date: Thu, 10 Jul 2003 08:53:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC:  what's in a stable series?
Message-ID: <20030710085338.C28672@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Jeff Garzik <jgarzik@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@osdl.org>
References: <3F0CBC08.1060201@pobox.com> <Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Jul 10, 2003 at 12:54:52AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 12:54:52AM -0300, Marcelo Tosatti wrote:
> The quota patches have been around for a long time, and Jan Kara has been
> trying to include for sometime now (since 2.4.20/21). I tried to avoid it.
> 
> Now I realized the possible drawbacks of it are minimal (if any) compared
> to the overall advantage it brings to Linux 2.4.

Also the quota patches don't change any ABI or API - userland can still
use the old ABI in addition to the new one, 16bit ondisk quotas are
still supported and filesystems couldn't care less which implementation
it plugs into - the API is the same.

