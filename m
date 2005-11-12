Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbVKLW3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbVKLW3r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVKLW3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:29:47 -0500
Received: from serena.fsr.ku.dk ([130.225.215.194]:12515 "EHLO
	serena.fsr.ku.dk") by vger.kernel.org with ESMTP id S964851AbVKLW3q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:29:46 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: gen_initramfs_list.sh: Cannot open 'y'
References: <58aaG-5AP-1@gated-at.bofh.it> <58ako-5Lz-11@gated-at.bofh.it>
From: Henrik Christian Grove <grove@fsr.ku.dk>
Organization: Forenede =?iso-8859-1?q?Studenterr=E5d_ved_K=F8benhavns?= Universitet
Date: Sat, 12 Nov 2005 23:29:43 +0100
In-Reply-To: <58ako-5Lz-11@gated-at.bofh.it> (Martin Schlemmer's message of
 "Sat, 12 Nov 2005 21:40:08 +0100")
Message-ID: <7gfyq1xzxk.fsf@serena.fsr.ku.dk>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer <azarah@nosferatu.za.org> writes:

> On Sat, 2005-11-12 at 21:22 +0100, Henrik Christian Grove wrote:
>> When I try to compile a 2.6.14 kernel on my new laptop, I get the
>> following error:
>> x40:~/kerne/linux-2.6.14# make
>>   CHK     include/linux/version.h
>>   CHK     include/linux/compile.h
>> dnsdomainname: Host name lookup failure
>>   CHK     usr/initramfs_list
>>   /root/kerne/linux-2.6.14/scripts/gen_initramfs_list.sh: Cannot open 'y'
>> make[1]: *** [usr/initramfs_list] Error 1
>> make: *** [usr] Error 2
>> 
>> I simply don't understand what it's trying to do, and google doesn't
>> seem to know that error. Can anyone here help?
>> 
>
> I am going to guess the help text is unclear or something, and you have
> in your .config:
>
> CONFIG_INITRAMFS_SOURCE="y"

Correct, the help text doesn't seem all that unclear, don't know what I
was thinking when I enter y.

Thanks.

.Henrik

-- 
"Det er fundamentalt noget humanistisk vås, at der er noget, 
 der hedder blød matematik."
   --- citat Henrik Jeppesen, dekan for det naturvidenskabelige fakultet
