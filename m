Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266121AbSLCH5p>; Tue, 3 Dec 2002 02:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266122AbSLCH5p>; Tue, 3 Dec 2002 02:57:45 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:43270 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S266121AbSLCH5p>; Tue, 3 Dec 2002 02:57:45 -0500
Date: Tue, 3 Dec 2002 19:04:56 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Greg KH <greg@kroah.com>
cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       <linux-security-module@wirex.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] LSM fix for stupid "empty" functions
In-Reply-To: <20021202065736.GA11477@kroah.com>
Message-ID: <Mutt.LNX.4.44.0212031855220.27503-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Dec 2002, Greg KH wrote:

> Anyway, there's no way to resolve both this percieved problem, and the
> "smaller and easier" patch that I proposed, right?  Unless we want to
> export all dummy operation functions for all modules to use?  I could do
> that, but it's pretty messy...

Yeah, very.  I guess a security module could check the kernel version and
print a warning to the effect "this module has not been verified with this
kernel version" either at compile or runtime, if needed.


- James
-- 
James Morris
<jmorris@intercode.com.au>



