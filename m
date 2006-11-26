Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967302AbWKZFtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967302AbWKZFtJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 00:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935247AbWKZFtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 00:49:08 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:27472 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S935246AbWKZFtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 00:49:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AymZxWAtZpFO11SiOnjdnVNB7+E2dlLaeatI3pW0jU7WXiv++sPpSelSXHQ1qcZrEKsFDS9v8VKk3TMPUna15ZFuH/4ThZJHn8GbpbDWERQfm6TnGdh7R4bQKRpMIFRYHunMTLRLZKFJDTtyHwVxJZyHcV+8sj+D6Ns4MVsgK+4=
Message-ID: <9b33a9230611252149m4da2634akbd355f026759ac70@mail.gmail.com>
Date: Sun, 26 Nov 2006 11:19:04 +0530
From: "sudhnesh adapawar" <sudhnesh@gmail.com>
To: lia64-sim@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: How to boot 2.6 kernel using hp ski simulator ???
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all !
          I wanted to boot 2.6 kernel configured for ia64 architecture
on ia32 archi using hp ski simulator ! But I failed to do so ! I
followed the following steps:
1) I used 'make ARCH=ia64 menuconfig' to configure and followed the
steps to get kernel image of version 2.6 ! I also selected the generic
type as Ski-simulator and also selected the HP-ski drivers something
simscsi,etc.etc.
2)  After this I gave the following command for the ski installed in
my OS kernel version 2.6 :
  $ ski bootloader vmlinux simscsi=/var/ski-disks/sd
3) Then gave run to start the process.The screen with the output as
"loading vmlinux" was displayed and the process halted....no working
further !
Querries:
 1) I am not getting what is happenning for 2.6 configured with ia64....???
......But I also downloaded the bootloader and vmlinux for 2.4 from Hp
ski simulator home site and tried with the above 2 steps and the 2.4
kernel was booted successfully....I dont know whether this kernel
image is configured for ia64 but whatever it worked !
2) Does ski supports for 2.6 kernel configured with ia64 archi as done
in above  step    no : 2) ??
3) How can we use sda i.e simulated filesystem....like can we mount it
?? Or whenever the kernel is booted using ski command the filesystem
it uses is sda ???
        Thank You....
       Please kindly Reply !
