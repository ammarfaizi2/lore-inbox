Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVCJEvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVCJEvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVCJEt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:49:58 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:48295 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262197AbVCJEsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 23:48:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=knEzqGslR3Dld1aPazci8kkkIBu9cJM1cm7N/aXrw6dsZPTnYfVagJzrOyZpKsIPzcB1TuYWHzPswHPXfGVxFCgpWlRHjhiPeBQgat5mifbGuc2tKiXpS3ZoQrDpoxXWEInXWP4CDq2tUSmLFjHgxx2oPuHS3YWLmNIOWyA8uZM=
Message-ID: <111a57ba050309204831b6047c@mail.gmail.com>
Date: Wed, 9 Mar 2005 23:48:44 -0500
From: John Yau <jyau.linux@gmail.com>
Reply-To: John Yau <jyau.linux@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sata_sil & Seagate HD solution
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I recently bought a computer with a Silicon Image 3512 SATA chipset
and a 200GB Seagate ST320082 hard drive without knowledge that these
two pieces of hardware don't play nicely.  However, I called Seagate
tech support and they told me that upgrading my bios would fix the
problem.  Fortunately my motherboard's manufacturer posted an upgrade
2-3 days after I learned of the fix.

I upgraded my motherboard's bios which updated the Silicon Image RAID
bios to 4.3.53.  That seems to have solved the incompatibility
problem.  I've had yet to have a crash during intense drive usage
while running with the MOD15 bug blacklist off.

Those poor souls that have a hard disk in the sata_sil blacklist, if
you're willing to risk it, try upgrading your bios, comment out your
hard drive from the black list and see if you're able to run at full
speed without the drive hanging.


John Yau
