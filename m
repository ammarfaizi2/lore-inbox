Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267011AbSLQT74>; Tue, 17 Dec 2002 14:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267014AbSLQT74>; Tue, 17 Dec 2002 14:59:56 -0500
Received: from mail.zmailer.org ([62.240.94.4]:11487 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S267011AbSLQT7x>;
	Tue, 17 Dec 2002 14:59:53 -0500
Date: Tue, 17 Dec 2002 22:07:49 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021217200749.GB32122@mea-ext.zmailer.org>
References: <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com> <3DFF7E7D.1080900@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DFF7E7D.1080900@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cutting down To:/Cc:)

On Tue, Dec 17, 2002 at 11:43:57AM -0800, H. Peter Anvin wrote:
> Linus Torvalds wrote:
> > The thing is, gettimeofday() isn't _that_ special. It's just not worth a
> > vsyscall of it's own, I feel. Where do you stop? Do we do getpid() too?
> > Just because we can?
> 
> getpid() could be implemented in userspace, but not via vsyscalls
> (instead it could be passed in the ELF data area at process start.)

  After fork() or clone()  ?
  If we had only spawn(), and some separate way to start threads...

...
> 	-hpa

/Matti Aarnio
