Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266168AbTLIJbB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266178AbTLIJbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:31:01 -0500
Received: from [202.37.96.11] ([202.37.96.11]:44501 "EHLO
	gatekeeper.tait.co.nz") by vger.kernel.org with ESMTP
	id S266168AbTLIJax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:30:53 -0500
Date: Tue, 09 Dec 2003 22:34:35 +1300
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Subject: Responds to ARP requests for specified subnet
To: linux-kernel@vger.kernel.org
Message-id: <3FD5972B.2010907@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5)
 Gecko/20030925
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The linux box shall respond to ARP requests for a specified subnet and accept an IP packets for that subnet though the box itself can reside in another subnet.
For example:
The box has IP 172.25.206.4, the mask is 255.255.255.0
The box shall responds to ARP requests for subnet 172.25.207.* and accept any IP packets for that subnet ie IP packets sent to the 172.25.207.2 etc. These packets will be proceed further by a user space application.

Could anybody please suggest a best techniques that can be used for that task.
I have looked at the netfilters hooks in the kernel, is this the right direction?
Can anybody please reference to the software, which does the similar thing.

Thank you very much for any help


