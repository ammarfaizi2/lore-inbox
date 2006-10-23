Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWJWSc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWJWSc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWJWSc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:32:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:34231 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965002AbWJWSc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:32:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kMiM1vXu4cbb6pedt8CthS7jvfM82cqvVwEN74/nTZIfJIHyq0vKdyAbCoegvtTjZC3f576Y2Zm2i1utO3vQiEyimk/UuZ8MJi5u+iZ+xlluP9SHQxyJULtVovTnlU6v5oqXz+9GT1Cgg/IxW8OfyP5jlxR4bqMj5V2OQXyOC/A=
Message-ID: <ae7121c60610231132w4e8b13c8y30865682e815b00c@mail.gmail.com>
Date: Mon, 23 Oct 2006 20:32:55 +0200
From: "Panagiotis Issaris" <panagiotis@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PC speaker listed as input device
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While trying to get my Hauppauge's remote control working, I noticed that my
PC speaker is getting recognized as an input device. This seems very weird
to me, is there some logic behind this?

 takis@aether:~$ cat /proc/bus/input/devices
I: Bus=0010 Vendor=001f Product=0001 Version=0100
N: Name="PC Speaker"
P: Phys=isa0061/input0
S: Sysfs=/class/input/input0
H: Handlers=kbd event0
B: EV=40001
B: SND=6
...

I'm using the 2.6.17 kernel (it is an Ubuntu kernel though).

With friendly regards,
Takis
