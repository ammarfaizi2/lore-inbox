Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbTIHCbt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 22:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTIHCbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 22:31:49 -0400
Received: from ns1.open.org ([199.2.104.1]:64403 "EHLO open.org")
	by vger.kernel.org with ESMTP id S261884AbTIHCbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 22:31:48 -0400
Message-ID: <3F5B87E2.6040501@open.org>
Date: Sun, 07 Sep 2003 19:32:50 +0000
From: Hal <pshbro@open.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030816
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: in 2.6.0-test4-bk8 and bk9 involving handling of ethernet interfaces
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When i was finishing up using a cross over cable to transfer data from 
my desktop to my labtop I notied an odd thing. After I ifconfig eth0 
down to close the interface on my desktop runing 2.6.0-test4-bk8 it 
froze all my ttys and ptys. I upgraded to bk9 and got the same thing.

To repeat the bug one will need two computers and a cross over cable. 
Connect the two computers, ifconfig the interfaces on each computer. 
Give them both an ip and then ifconfig up them both. Now to get the bug 
ifconfig the interface on the computer runing a 2.6 kernel down and 
hopefully there will be a system freeze.

For more information im using a Net Gear fa311 ethernet NIC with the 
Natsemi ethernet drivers.

