Return-Path: <linux-kernel-owner+w=401wt.eu-S932280AbXAIVEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbXAIVEy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 16:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbXAIVEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 16:04:54 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:64464 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280AbXAIVEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 16:04:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N0V+FlwI9yHFZsqzFjVEfGK3J53QCesKEul80QwuwrIxxA8B2SHAWdnnYuxbJQ8De6t3lKjPMXvHUab6YqcKTdEnv4gpxoVBEvKEbovobtdMCg8jvFQbeNeL01AllG05Lu4m+BZJR2QH/kni+tbJXV0BN1TB4BumjrK3pfETIaQ=
Message-ID: <8355959a0701091304g3efc0051o71466d871d5494e7@mail.gmail.com>
Date: Wed, 10 Jan 2007 02:34:52 +0530
From: Akula2 <akula2.shark@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: Jumping into Kernel development: About -rc kernels...
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490701090749u3fc503f3vb05a7063bf40c120@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8355959a0701090733l74d03792q16b3022d949c7ae1@mail.gmail.com>
	 <9a8748490701090749u3fc503f3vb05a7063bf40c120@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/07, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Depends on what you want to do.  If you want a stable kernel to use in
> production you should probably pick the latest stable kernel

I am a Linux user/developer in all my IT career which began in 1997.
But always my goal to be a kernel developer and a contributor after
getting hardened. But my career didn't allow me to do this LKML work
except regular reading (frequent change of projects & skills in
Telecom/Embedded). Since last year am with Big B (don't want to name
my company here. Because many people on this list are from the same
company, might get offended because of my novice questions. Or, They
might see me as a silly guy!)

But my interest reached to impossible level to hold anymore. From now
on I want to be an active contributer among this great community :)

Sorry for this big rant. These kernels I test would be for my
Workstations/Embedded  boards (ARM & Power) at my home & my Labs
(example ThinkCentre A51). Not for any production Servers as of now.

> (currently that's 2.6.19.1).

I did start involving with LKML & posted a few too. But, I didn't get
any pointer from you guys.

http://lkml.org/lkml/2007/1/4/228
http://lkml.org/lkml/2007/1/5/74

Maybe I did something naive or stupid in the effort above or in the
posting here. Dunno!


> If you want to help fix bugs, develop features, test etc, then it is
> usually best to use the latest development snapshot available.  An
> easy way to always have the tip of the tree available is to use git -
> see this document for more info : http://linux.yyz.us/git-howto.html

Just now compiled 2.6.20-rc4 too.  So I have already started the
effort, here is we go:-

[sukhoi@Typhoon linux-2.6.20-rc4]$ ll /boot/
total 13004
-rw-r--r-- 1 root root   70195 Dec 16 04:22 config-2.6.18-1.2868.fc6
drwxr-xr-x 2 root root    4096 Jan 10 02:15 grub
-rw------- 1 root root 1519417 Dec 26 19:35 initrd-2.6.18-1.2868.fc6.img
-rw------- 1 root root 1391180 Jan  9 23:12 initrd-2.6.19.1-Topol-M.img
-rw------- 1 root root 1383782 Jan 10 02:15 initrd-2.6.20-rc4.img
-rw-r--r-- 1 root root   94600 Jul 13 10:44 memtest86+-1.65
-rw-r--r-- 1 root root   95025 Dec 16 04:23 symvers-2.6.18-1.2868.fc6.gz
lrwxrwxrwx 1 root root      21 Jan 10 02:14 System.map -> System.map-2.6.20-rc4
-rw-r--r-- 1 root root  887701 Dec 16 04:22 System.map-2.6.18-1.2868.fc6
-rw-r--r-- 1 root root  965328 Jan  9 23:11 System.map-2.6.19.1-Topol-M
-rw-r--r-- 1 root root  957961 Jan 10 02:14 System.map-2.6.20-rc4
lrwxrwxrwx 1 root root      18 Jan 10 02:14 vmlinuz -> vmlinuz-2.6.20-rc4
-rw-r--r-- 1 root root 1816959 Dec 16 04:22 vmlinuz-2.6.18-1.2868.fc6
-rw-r--r-- 1 root root 2036631 Jan  9 23:11 vmlinuz-2.6.19.1-Topol-M
-rw-r--r-- 1 root root 1993172 Jan 10 02:14 vmlinuz-2.6.20-rc4


> Jesper Juhl <jesper.juhl@gmail.com>

Thanks,
~Akula2
