Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbRENNi1>; Mon, 14 May 2001 09:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262090AbRENNiQ>; Mon, 14 May 2001 09:38:16 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:38661 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262106AbRENNiC>;
	Mon, 14 May 2001 09:38:02 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: nick@snowman.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Minor nit to pick 
In-Reply-To: Your message of "Mon, 14 May 2001 00:16:50 -0400."
             <Pine.LNX.4.21.0105140014530.20415-100000@ns> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 May 2001 23:37:55 +1000
Message-ID: <3260.989847475@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001 00:16:50 -0400 (EDT), 
<nick@snowman.net> wrote:
>After running make menuconfig (and it's friends) you get told
>to type "make bzImage" which is only right for i386, and IMHO should be
>changed to be arch dependant.

The 2.5 Makefile rewrite splits the kernel build into three phases:
configure, compile to vmlinux/modules and convert vmlinux to the
required install format.  bzImage is an example of install format and
install formats will be architecture dependent in 2.5.  We're working
on it.

