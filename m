Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSDECGL>; Thu, 4 Apr 2002 21:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311092AbSDECGC>; Thu, 4 Apr 2002 21:06:02 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:2552
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311025AbSDECFu>; Thu, 4 Apr 2002 21:05:50 -0500
Date: Thu, 4 Apr 2002 18:07:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup KERNEL_VERSION definition and linux/version.h
Message-ID: <20020405020752.GJ961@matchmail.com>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020404011251Z313077-616+5298@vger.kernel.org> <17913.1017884166@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 11:36:06AM +1000, Keith Owens wrote:
> On Thu, 04 Apr 2002 10:12:29 +0900, 
> Hiroyuki Toda <might@might.dyn.to> wrote:
> >
> >Keith> This file will change completely in 2.5 when kbuild 2.5 goes in.  Why
> >Keith> does it need to be rearranged in 2.4?
> >
> >Will kbuild 2.5 go in 2.4 tree also?
> 
> No, but version.h is working at the moment in 2.4.  Why change it?

Why do so many drivers enable options depending on the kernel version?
Shouldn't that be stripped out before a patch is accepted into the kernel?
