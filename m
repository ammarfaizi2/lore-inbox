Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262424AbSJDQZi>; Fri, 4 Oct 2002 12:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262426AbSJDQZi>; Fri, 4 Oct 2002 12:25:38 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:28179 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262424AbSJDQZf>; Fri, 4 Oct 2002 12:25:35 -0400
Date: Fri, 4 Oct 2002 17:31:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Greg KH <greg@kroah.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] minor devfs cleanup for 2.5.40
Message-ID: <20021004173105.A3478@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Richard Gooch <rgooch@ras.ucalgary.ca>, Greg KH <greg@kroah.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20021003213908.GB1388@kroah.com> <200210041617.g94GHY008334@vindaloo.ras.ucalgary.ca> <20021004172457.A3390@infradead.org> <200210041627.g94GR7M08781@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210041627.g94GR7M08781@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Fri, Oct 04, 2002 at 10:27:07AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 10:27:07AM -0600, Richard Gooch wrote:
> Those names *were* in mainline. They've been there all through 2.4.x.
> It's a useful feature that is *still* being used. Change this and lots
> of people will get a panic at boot because there root FS is "missing".

They have never been the devfs names in_any_ kernel.  Linus made you change
to saner names before merging devfs (saner code would also have been
a good idea, btw..).  Anyway, 2.5 is going to initramfs, so feel free
to put devfsd into your initramfs.

