Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317777AbSGaFZT>; Wed, 31 Jul 2002 01:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317778AbSGaFZT>; Wed, 31 Jul 2002 01:25:19 -0400
Received: from smtp.cs.curtin.edu.au ([134.7.1.1]:5046 "EHLO
	smtp.cs.curtin.edu.au") by vger.kernel.org with ESMTP
	id <S317777AbSGaFZS>; Wed, 31 Jul 2002 01:25:18 -0400
Message-Id: <5.1.1.6.0.20020731132143.00bc5078@pop.cs.curtin.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 31 Jul 2002 13:28:40 +0800
To: linux-kernel@vger.kernel.org
From: David Shirley <dave@cs.curtin.edu.au>
Subject: Network Routing Problems on Dual NIC Box
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm not sure this is the right list for this question so bear with me :)

I have a machine that has 2 NIC's both on different subnet's lets
say 192.168.2.200 and 192.168.3.200

We are running a proxy server on this box, and the box is called proxy
which when you do a lookup points to 192.168.3.200

the problem is when machines on the 192.168.2.0 subnet try to
access proxy:80 the session connects but no data is being received on the
192.168.2.0 box.

I think its because proxy accepts on the .3 but then tries to send all the data
via the .2 interface because its directly connected and the .2 box ignores it
because its not coming from the .3

is this true?
how can i get proxy to send data back via the .3 interface? rather than via .2

btw its 2.2.19 box running redhat 6.2

Cheers
Dave








/----------------------------------------------------------
David Shirley
System's Administrator
Computer Science - Curtin University
(08) 9266 2986
----------------------------------------------------------/

