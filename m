Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbTHZIcQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 04:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTHZIcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 04:32:15 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:19861 "EHLO
	mwinf0604.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263147AbTHZIcO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 04:32:14 -0400
From: Laurent =?iso-8859-1?q?Hug=E9?= <laurent.huge@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Reading accurate size of recepts from serial port
Date: Tue, 26 Aug 2003 10:32:13 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308261032.13576.laurent.huge@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I feel sorry to annoy you again with my problem, but I can't imagine there is 
no way to know the accurate size of a recept on the serial port.

I'm trying to implement a network driver above this port :
	- I've done a raw read from 0x03f8 but it was not fast enougth (I'm working 
at 115200 bauds) ;
	- I've created a line discipline, but it can't (according to this mailing 
list) give me the real size of what was read.
Does anybody know a way to read from the serial port with speed and accuracy ?

I'm really confused because the serial driver on Windows can do such a thing, 
and, since I've no other way to find the size of PDU (CCSDS segments), I'm 
obliged to rely on the serial port to let me know that size.
Thanks in advance,
-- 
Laurent Hugé.

