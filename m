Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284871AbRLZUCe>; Wed, 26 Dec 2001 15:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284831AbRLZUCP>; Wed, 26 Dec 2001 15:02:15 -0500
Received: from cx662584-g.okcnc1.ok.home.com ([24.254.203.6]:12437 "HELO
	cx662584-g.oknc1.ok.home.com") by vger.kernel.org with SMTP
	id <S284800AbRLZUCF>; Wed, 26 Dec 2001 15:02:05 -0500
Subject: Re: [PATCH] fully preemptible kernel
From: Steve Bergman <steve@rueb.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1007930466.11789.2.camel@phantasy>
In-Reply-To: <1007930466.11789.2.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 26 Dec 2001 14:02:01 -0600
Message-Id: <1009396922.1678.9.camel@voyager.rueb.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-12-09 at 14:41, Robert Love wrote:
> Updated preempt-kernel patches for 2.4.16 and 2.4.17-pre6 are now
> available at:
> 
>  	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel
> 

Hi,

I just compiled 2.4.17 with the patch from your site that looks to be
for 2.4.17-final.  Unfortunately, several modules (e.g. unix.o) fail on
load with an undefined symbol error (preempt_schedule).  FWIW, I also
have the patch that started the recent "Make highly niced processes run
only when idle" thread.  Which reminds me, I'm anxious to try out your
"fixed" version of SCHED_IDLE when it's ready. ;-) 

