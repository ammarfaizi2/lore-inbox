Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbRGACk1>; Sat, 30 Jun 2001 22:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264948AbRGACkR>; Sat, 30 Jun 2001 22:40:17 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:30482 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264944AbRGACkG>;
	Sat, 30 Jun 2001 22:40:06 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
cc: "Adam J. Richter" <adam@yggdrasil.com>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs 
In-Reply-To: Your message of "Sat, 30 Jun 2001 16:01:01 +0100."
             <20010630160101.G12788@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 Jul 2001 12:39:59 +1000
Message-ID: <6558.993955199@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2001 16:01:01 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>I have confirmed that Keith Owens patch doesn't work with xconfig - you
>can't select any option which has been define_bool'd to 'n'.

My patch only define_bool's the arch variables.  None of those are
selectable.

