Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWJWSxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWJWSxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWJWSxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:53:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:16189 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965036AbWJWSxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:53:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Lp2u1pBeteM3IAOhj8xf4bNOVpmKYjXhF5YgCiMUuQLTj2gsXajjzz9atgeT+vV5Ymb+rZizEg1Q2i6Cph+1rOH43rW0gj4Y7wYe3JjPusF8UaGzye7ac3pBFm0yMc1hx6RBtbQ+j97cw8KTpTkuoLVdduOnT+Kpo79CUXoywOY=
Message-ID: <ae7121c60610231153g4a55968gf2da729c13c8f18b@mail.gmail.com>
Date: Mon, 23 Oct 2006 20:53:07 +0200
From: "Panagiotis Issaris" <panagiotis@gmail.com>
To: linux-kernel@vger.kernel.org,
       "Panagiotis Issaris" <takis.issaris@uhasselt.be>
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
