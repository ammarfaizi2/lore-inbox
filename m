Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266366AbRGBEw3>; Mon, 2 Jul 2001 00:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbRGBEwT>; Mon, 2 Jul 2001 00:52:19 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:15632 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S266366AbRGBEwG>; Mon, 2 Jul 2001 00:52:06 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, rhw@MemAlpha.CX,
        rmk@arm.linux.org.uk
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs 
In-Reply-To: Your message of "Sun, 01 Jul 2001 21:46:04 MST."
             <200107020446.VAA02397@adam.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jul 2001 14:51:32 +1000
Message-ID: <24426.994049492@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jul 2001 21:46:04 -0700, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>Can you even write a hypothetical example?

if [ "$CONFIG_foo" = "n" -a "$CONFIG_bar" = "n" ]; then
  define_bool "$CONFIG_ALLOW_foo_bar n
fi
....
dep_tristate CONFIG_baz $CONFIG_ALLOW_foo_bar

