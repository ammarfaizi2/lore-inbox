Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317421AbSFROQ3>; Tue, 18 Jun 2002 10:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317422AbSFROQ2>; Tue, 18 Jun 2002 10:16:28 -0400
Received: from thufir.bluecom.no ([217.118.32.12]:57615 "EHLO
	thufir.bluecom.no") by vger.kernel.org with ESMTP
	id <S317421AbSFROQ1>; Tue, 18 Jun 2002 10:16:27 -0400
Date: Tue, 18 Jun 2002 16:12:42 +0200
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: small 5575 PCI ATM fix
Message-ID: <20020618141242.GB11756@kernelspace.com>
References: <20020618133527.GA11756@kernelspace.com> <20020618155837.S758@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020618155837.S758@suse.de>
User-Agent: Mutt/1.3.28i
From: Petter <petter@kernelspace.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 03:58:37PM +0200, Dave Jones wrote:
> On Tue, Jun 18, 2002 at 03:35:27PM +0200, Petter wrote:
> Error handling in that driver seems to be 'creative' at best.

I agree.

> No releasing of already allocated resources, just returning -EAGAIN
> everywhere, and no checking for already allocated resources.
> 
> Someone with too much time on their hands[1] could probably clean this
> up to free allocated resources on failure and return -ENOMEM on
> allocation failures.


Yup, but I do not have that much spare time ;)
I just looked at the code for two seconds and thought that I'd send a
quick fix for it.


Regards


Petter Wahlman
