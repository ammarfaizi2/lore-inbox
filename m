Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285490AbRLNUPw>; Fri, 14 Dec 2001 15:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285484AbRLNUPn>; Fri, 14 Dec 2001 15:15:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3087 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285483AbRLNUPf>;
	Fri, 14 Dec 2001 15:15:35 -0500
Date: Fri, 14 Dec 2001 21:09:48 +0100
From: Jens Axboe <axboe@suse.de>
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
Cc: Kirk Alexander <kirkalx@yahoo.co.nz>, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20011214200948.GT1180@suse.de>
In-Reply-To: <20011214041151.91557.qmail@web14904.mail.yahoo.com> <20011214172419.Q1591-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011214172419.Q1591-100000@gerard>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14 2001, Gérard Roudier wrote:
> > I fixed the problem by seeing what the sym
> > driver did i.e. the patch below
> > This may not be right at all, and I haven't had a
> > chance to boot the kernel - but it did build OK.
> 
> The ncr53c8xx and sym53c8xx version 1 use the obsolete scsi eh handling.
> Moving the eh code from sym53c8xx_2 (version 2) to ncr53c8xx/sym53c8xx is
> quite feasible, but may-be it is just useless given sym53c8xx_2. For now,
> it seems that sym53c8xx_2 replaces both ncr/sym53c8xx without any loss of
> reliability and performance.

Gerard,

For 2.5, why don't we just yank old sym and ncr out of the kernel? Is
there _any_ reason to keep the two older ones given your new driver
handles it all?

-- 
Jens Axboe

