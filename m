Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbUCCTrV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbUCCTqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:46:45 -0500
Received: from p10068181.pureserver.de ([217.160.75.209]:6160 "EHLO
	www.kuix.de") by vger.kernel.org with ESMTP id S262569AbUCCTpd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:45:33 -0500
Message-ID: <404635E6.50409@kuix.de>
Date: Wed, 03 Mar 2004 20:45:42 +0100
From: Kai Engert <kaie@kuix.de>
Reply-To: kai.engert@gmx.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030721 wamcom.org
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Update on ieee1394 trouble with latest 2.4.x
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of days ago I posted a report about my problems with ieee1394 
mass storage devices to the list. Here is an update.

Meanwhile Ben Collins contacted me and recommend me to try out some sbp2 
module options.

It turned out the "stall and timeout" problem can be suppressed by using 
the sbp2_serialize_io=1 module param when loading module sbp2. This 
works for me with several devices I have tested.

Regards,
Kai


