Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279935AbRJ3MMY>; Tue, 30 Oct 2001 07:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279936AbRJ3MMO>; Tue, 30 Oct 2001 07:12:14 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12041 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S279935AbRJ3MMF>; Tue, 30 Oct 2001 07:12:05 -0500
Date: Tue, 30 Oct 2001 13:12:33 +0100
From: Jan Kara <jack@suse.cz>
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops: Quota race in 2.4.12?
Message-ID: <20011030131233.A6302@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011028215818.A7887@netnation.com> <20011029144441.E11994@atrey.karlin.mff.cuni.cz> <20011029083044.G17389@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011029083044.G17389@netnation.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Oct 29, 2001 at 02:44:41PM +0100, Jan Kara wrote:
> 
> >   I'd also blame some SMP locking (I think that on UP everything was tested well) but
> > everything should be protected by lock_kernel() and it seems to me that everything really
> > is protected. Anyway I'll try to find the problem.
> 
> I notice you just recently posted a patch to fix possible list
> corruption.  Could this be related?
  Nope. That was a fix specific to code in -ac kernel..

								Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs
