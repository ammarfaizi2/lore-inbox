Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWEIUkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWEIUkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWEIUku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:40:50 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34565 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751168AbWEIUku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:40:50 -0400
Date: Tue, 9 May 2006 22:40:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Richard J Moore <richardj_moore@uk.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>, suparna@in.ibm.com
Subject: Re: [RFC] [PATCH 3/6] Kprobes: New interfaces for user-space probes
Message-ID: <20060509204052.GN3570@stusta.de>
References: <20060509093614.GB26953@infradead.org> <OFB21F3208.CA125B3A-ON41257169.005345DD-41257169.005375F5@uk.ibm.com> <20060509151857.GB16332@infradead.org> <y0mk68vyu2y.fsf@ton.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y0mk68vyu2y.fsf@ton.toronto.redhat.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 01:41:09PM -0400, Frank Ch. Eigler wrote:
> 
> hch wrote:
> 
> > [...]  why the hell do you guys expect to get a huge piele of flaky
> > code integrate that slows down pagecaches and adds thousands of
> > lines of undebuggable and untestable code without submitting
> > something that actually calls it. [...]
> 
> It is reasonable to want to see code that exercises this function.
> Until systemtap does, hand-written examples can surely be provided.

It's not about examples, it's about in-kernel users.

If the code using it is not yet ready for submission, there's no need to 
add interfaces for it now.

> - FChE

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

