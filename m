Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131508AbRDFLyp>; Fri, 6 Apr 2001 07:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131509AbRDFLyf>; Fri, 6 Apr 2001 07:54:35 -0400
Received: from t2.redhat.com ([199.183.24.243]:41204 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131508AbRDFLyU>; Fri, 6 Apr 2001 07:54:20 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.30.0104051751410.20174-100000@andrew.triumf.ca> 
In-Reply-To: <Pine.LNX.4.30.0104051751410.20174-100000@andrew.triumf.ca> 
To: Andrew Daviel <advax@triumf.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: syslog insmod please! 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Apr 2001 12:53:35 +0100
Message-ID: <693.986558015@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


andrew@andrew.triumf.ca said:
>  Is there a good reason why insmod should not call syslog() to log any
> module that gets installed ? I know things like bttv get very verbose
> in the module itself, and I tried patching insmod to log the first
> argument and it seemed to work for me.

Consider "insmod unix.o".

I'm not wonderfully impressed with the way that you can't load the FPU 
emulation module on ARM at the moment without having some form of FPU 
emulation in your kernel already, either :)

--
dwmw2


