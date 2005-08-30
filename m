Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVH3MaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVH3MaD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 08:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbVH3MaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 08:30:03 -0400
Received: from web53605.mail.yahoo.com ([206.190.37.38]:10662 "HELO
	web53605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751419AbVH3MaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 08:30:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=acX3IsF/Ila72uZ2FlOLmxFdGC21+ei/eXY9w2HCLTYIfLLDcFeGVD1owLZouSFmUuB3ZuybARV3kMtkG8pgsQxHI0w7vJ86iWSLm34/cUqRN7Jtpf0HXkWxlY7aE8v96aAy060+tvWyVlw5iwnuiuusxPccdL1qIrVkDPOyLeY=  ;
Message-ID: <20050830122937.79855.qmail@web53605.mail.yahoo.com>
Date: Tue, 30 Aug 2005 22:29:37 +1000 (EST)
From: Steve Kieu <haiquy@yahoo.com>
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <431448F7.2020506@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have "fixed" the problem in a very wierd way.Reading
your post I thought maybe when removing the driver
itself it set some bit incorrectly. Then I decided to
do:

Boot with init=/bin/bash  so bypass all other things.
modprobe skge

run ifconfig eth0 ip_num  up


ping  a host

then while pinging hit Ctrl+Alt+Del key to hot reboot
the system.

I still see the light at the hub lits. Now I boot to
winXP and as I expected , it worked!

No I boot 2.6.11 and it worked, so the problem resolve
but I am tooooo scared to run 2613 now :-)

Hope this information helps debuging the driver.

Thanks.

S.KIEU

Send instant messages to your online friends http://au.messenger.yahoo.com 
