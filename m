Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287595AbSA1NXN>; Mon, 28 Jan 2002 08:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288302AbSA1NXD>; Mon, 28 Jan 2002 08:23:03 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:11526 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287595AbSA1NW5>;
	Mon, 28 Jan 2002 08:22:57 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "kumar M" <kumarm4@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: exporting kernel symbols 
In-Reply-To: Your message of "Mon, 28 Jan 2002 13:13:38 -0000."
             <F127UjC2XxF6P0mCmg600006436@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 29 Jan 2002 00:22:44 +1100
Message-ID: <6909.1012224164@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002 13:13:38 +0000, 
"kumar M" <kumarm4@hotmail.com> wrote:
>On a freshly installed RedHat 7.1 machine
>with 2.4.2-2 kernel,  a 'make modules'
>throws up  errors such as  :
>----------------------------------------
>/usr/src/linux-2.4/include/linux/module.h:173: nondigits in number and not 
>hexadecimal
>/usr/src/linux-2.4/include/linux/module.h:173: parse error before `62dada05'
>/usr/src/linux-2.4/include/linux/module.h:173: 
>`inter_module_register_R_ver_str' declared as function returning a function
>/usr/src/linux-2.4/include/linux/module.h:173: warning: function declaration 
>isn't a prototype
>.......................................................
>
>So we do a 'make mrproper' and 'make menuconfig' and
>save and exit without any changes to configuration.
>Then we rebuild the kernel.
>make dep & make modules are done smoothly.
>
>Can you let us know why we should be doing make mrproper
>on a system freshly installed  with redhat 7.1(2.4.2-2smp)

RedHat do something strange with module symbols.  I have never
understood what they are trying to do nor why it messes up a normal
kernel compile.  Ask RH what the build procedure is for their
distributed kernels and why a normal build goes wrong.

