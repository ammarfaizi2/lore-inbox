Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129434AbQKYNye>; Sat, 25 Nov 2000 08:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131173AbQKYNyZ>; Sat, 25 Nov 2000 08:54:25 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:3599 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S129434AbQKYNyF>;
        Sat, 25 Nov 2000 08:54:05 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: jamagallon@able.es
cc: linux-kernel@vger.kernel.org
Subject: Re: LKCD from SGI 
In-Reply-To: Your message of "Sat, 25 Nov 2000 14:18:30 BST."
             <20001125141830.C2877@werewolf.able.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 26 Nov 2000 00:23:57 +1100
Message-ID: <7235.975158637@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2000 14:18:30 +0100, 
"J . A . Magallon" <jamagallon@able.es> wrote:
>On Sat, 25 Nov 2000 02:58:37 Keith Owens wrote:
>> 2.5 kernel build wish list[1] has a couple of entries for standardising
>> the install targets.  My thinking (and I know that some people disagree
>> with this) is that the standard targets of a linux compile are only
>> 
>> * vmlinux
>> * System.map
>> * modules in the kernel tree (not installed yet)
>> * any other bits and pieces that are required to compile external
>>   modules against this config.
>
>Could the default target install names int the std kernel be changed to 
>System.map -> System.map-$(KERNELRELEASE)
>vmlinuz    -> vmlinuz-$(KERNELRELEASE)
>and then symlink to that ?

We could do a lot of things in the install targets.  But none of them
are going to be done before kernel 2.5.  We are in code freeze (is this
freeze number 4 or 5?).  Changing the install method just before a new
kernel branch is released will not be popular with the distributors.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
