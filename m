Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbUKXJ10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbUKXJ10 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbUKXJ10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:27:26 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:64774 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262566AbUKXJ0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:26:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=uldBIz4840Qa9+moDO2iYV92R5Nizj8oqldr0ImMIFkPhX/odrAd6YQvZsXIbhqiIhVj2bZHO119Mb0gAzK+RJ91Hbrv9vTRQLg9ybbVwBKooIPFnJCK5KfL1kBaKTO3VEBcpcOsYdYdFFF0vJfrr4Slvj24b0LhRIZq4PVJke4=
Message-ID: <b2fa632f041124012543876b61@mail.gmail.com>
Date: Wed, 24 Nov 2004 14:55:57 +0530
From: Raj <inguva@gmail.com>
Reply-To: Raj <inguva@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Delay in unmounting a USB pen drive
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SuSE kernel 2.6.5:

My USB pen drive has a vfat FS. When i transfer some files & try to
unmount the drive ( umount /mnt ) , the command appears hung. CTRL+C also
does not work. Only later did i realise that it was actually taking a
longer time ( 10 - 15 sec )
to unmount.

My questions are:
- Why is it taking a long time to unmount ?
- Is it safe to remove the pen drive from it's slot when the umount is still in
  progress ?? ( I tried this the first time & maybe lucky me, the
files copied were fine )

TIA
-- 
######
raj
######
