Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269900AbRHEB4v>; Sat, 4 Aug 2001 21:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269896AbRHEB4l>; Sat, 4 Aug 2001 21:56:41 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:31504 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269900AbRHEB4d>;
	Sat, 4 Aug 2001 21:56:33 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: tegeran@home.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Possibly unfreezable system? 
In-Reply-To: Your message of "Sat, 04 Aug 2001 14:52:14 MST."
             <01080414521403.02694@c779218-a> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 Aug 2001 11:56:38 +1000
Message-ID: <2314.996976598@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Aug 2001 14:52:14 -0700, 
Nicholas Knight <tegeran@home.com> wrote:
>I've lately seen many complaints regarding the inability to even access a 
>system that something (such as kswapd) is going crazy on.
>The solution, to me, seems simple, have the kernel reserve some extra RAM 
>at boot (a few megs), and dictate that it get at least X amount of 
>processor time, consistantly, to allow for the following:
>An alt-sysrq key that switches to a certain virtual console, kills 
>whatever might already be running there, and allow a person to log in in 
>order to kill whatever is causing the system to freeze, run out of 
>memory, etc. The program(s) running here would run in that extra RAM the 
>kernel reserved at boot.

It already exists and is called kdb.
ftp://oss.sgi.com/projects/kdb/download/ix86

