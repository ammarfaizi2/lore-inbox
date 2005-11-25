Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbVKYKeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbVKYKeI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 05:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVKYKeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 05:34:08 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:42199 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751434AbVKYKeH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 05:34:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eX73UZ85j0cN3opiK4L49N7vmoZe9YQc1lDqYG4R1/n+NQurChphvF9eTEjaBmQU9KF/Oetov5HdKlMhVuevtOQGk44/Qk3zSE9cRKjstnEWmb2ORqlcEfrCbbzuuS0U8wPT2RHHru9CGF0Vp2RFRXqRBsdru1VSFMMz5gGx8Vk=
Message-ID: <5a2cf1f60511250234p3f00351ah956cb3615e0c1dbe@mail.gmail.com>
Date: Fri, 25 Nov 2005 11:34:06 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: defective RAM: corrupted ext3 FS. How to identify corrupted files/directories?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

My RAM died, and it corrupted my file system. It seems like this
machine just wants to die... [1]

After removing the faulty RAM, I can boot. I made extensive memtest86+ tests.
I now have my home partition mounted as read-only because of said corruption.

I see a bunch of "ext3_readdir: directory xxxx contains a hole at
offset xxxxx"  when I try to access some parts of my disk.

I postponed fscking the FS until I have identified the faulty data.

I was thinking of doing a rsync --dry-run against a known working
backup and check the logs. Any better idea? Is there a way to convert
the directory IDs into file paths?

I have around 500 000 files on that partition. It takes time checking them all.

Cheers,

Jerome

[1] http://lkml.org/lkml/2005/2/4/51
