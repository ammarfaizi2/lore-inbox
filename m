Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132881AbRDEMdt>; Thu, 5 Apr 2001 08:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132878AbRDEMcu>; Thu, 5 Apr 2001 08:32:50 -0400
Received: from mail.zmailer.org ([194.252.70.162]:34820 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S132879AbRDEMce>;
	Thu, 5 Apr 2001 08:32:34 -0400
Date: Thu, 5 Apr 2001 15:31:45 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Bart Trojanowski <bart@jukie.net>,
        Manoj Sontakke <manojs@sasken.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: which gcc version?
Message-ID: <20010405153145.C873@mea-ext.zmailer.org>
In-Reply-To: <20010405150219.B873@mea-ext.zmailer.org> <Pine.LNX.4.21.0104051930580.2687-100000@pcc65.sasi.com> <Pine.LNX.4.30.0104050732080.13246-100000@localhost> <20010405150219.B873@mea-ext.zmailer.org> <25567.986473592@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25567.986473592@redhat.com>; from dwmw2@infradead.org on Thu, Apr 05, 2001 at 01:26:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2001 at 01:26:32PM +0100, David Woodhouse wrote:
> matti.aarnio@zmailer.org said:
> > 	To think of it, there really should be explicitely callable
> > 	versions of these with LinuxKernel names for them, not gcc
> > 	builtins.   That way people would *know* they are doing
> > 	something, which is potentially very slow.
> > 	(And the API would not change from underneath them.) 
> 
> Like include/asm-*/div64.h::do_div()?

	Like that (*) - but that has limited value spaces,
	the divider can be at most 32 bits, probably far less.

> --
> dwmw2

/Matti Aarnio

(*) Trying to recall when I, and few others, created that beast.
    The divisor code in itself isn't mine, but the idea of supporting
    %Ld at printk() most definitely is..
