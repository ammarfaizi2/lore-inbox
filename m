Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312582AbSEXWpk>; Fri, 24 May 2002 18:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312600AbSEXWpj>; Fri, 24 May 2002 18:45:39 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:45051 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S312582AbSEXWph>; Fri, 24 May 2002 18:45:37 -0400
Date: Fri, 24 May 2002 15:45:58 -0700
From: Chris Wright <chris@wirex.com>
To: Erik McKee <camhanaich99@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.17 Problem
Message-ID: <20020524154558.A6590@figure1.int.wirex.com>
Mail-Followup-To: Erik McKee <camhanaich99@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020523150539.1059.qmail@web14201.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Erik McKee (camhanaich99@yahoo.com) wrote:
> Ok, I am becoming a frequent poster here.  Nothing in the logs on this one
> either.  Left 2.5.17 running overnight on this box which used to be rock solid
> unser 2.4.  kde was running, with a screensaver.  On attempting to use the box,
> mouse mvement did dispell the screensaver.  alt-ctrl-f2 to get to a vc however
> left me with a clean black screen.  Nothing worked....alt-sysrq -s or
> alt-sysrq-u ddin't produce any disk activity.  alt-sys-rq-b did however reboot
> the system.  only issue was unclean raid array afterwards ;)

is this, by chance, a UP machine with:
CONFIG_SMP=y
CONFIG_PREEMPT=y

i've been seeing regular kernel hangs obtaining the BKL with this
configuration.

thanks,
-chris
