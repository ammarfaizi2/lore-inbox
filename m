Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbQLNAdG>; Wed, 13 Dec 2000 19:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130391AbQLNAc4>; Wed, 13 Dec 2000 19:32:56 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:11832 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129667AbQLNAcp>; Wed, 13 Dec 2000 19:32:45 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: insmod problem after modutils upgrading 
In-Reply-To: Your message of "Wed, 13 Dec 2000 22:13:29 -0000."
             <E146K9T-0003MT-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Dec 2000 11:02:09 +1100
Message-ID: <1696.976752129@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000 22:13:29 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> previously because nobody used those options.  Since these are bugs in
>> the modules and only a few modules are affected (less than 5 reported),
>> the fix is to correct the modules that have coding errors.
>
>That wont be happening in 2.2 until 2.2.19 which probably means 6 months.
>If this is your decision please make it abundantly clear that the new
>modutils are a 2.4 only package.

Well, if it is going to take that long to fix 2.2 ...  modutils 2.3.23
will make this a semi-warning.  modules with invalid MODULE_PARM for
options that are not used will load, but the module will not support
persistent data.  If somebody actually tries to use one of the invalid
options then insmod will fail, it already does this.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
