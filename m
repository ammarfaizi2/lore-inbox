Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266420AbUBLNmP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 08:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266433AbUBLNmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 08:42:15 -0500
Received: from snscrew.net ([62.212.110.148]:28720 "EHLO ns1-sns.snscrew.net")
	by vger.kernel.org with ESMTP id S266420AbUBLNlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 08:41:15 -0500
Message-ID: <402B8256.8070503@snscrew.net>
Date: Thu, 12 Feb 2004 14:40:38 +0100
From: claude <claude@snscrew.net>
Reply-To: claude@snscrew.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dmo@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: Mylex DAC960 - linux-2.6.2 - sysfs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a box, with 1 Mylex dac960 card (3 physical drive,
1 logical drive), running linux-2.6.2.

My problem is that mylex driver seems to export all possible logical
drive to sysfs (eg : Looking at /sys/block shows me reference for c0d0
to c0d31, but i only have c0d0).

I've read DAC960.{c,h} in kernel source tree, but my poor knowledge in C
cannot help me there. (I can't find something related to sysfs in that
code :(. Perhaps it happens elsewhere.)

So my question is : Is there any way to report only existing logical drive
to sysfs ?

Thanks in advance. (If you need testing or others, please ask :) )
