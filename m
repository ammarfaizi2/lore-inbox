Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVI0MWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVI0MWu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVI0MWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:22:50 -0400
Received: from beta.sbs.sk ([192.108.125.12]:59624 "HELO beta.sbs.sk")
	by vger.kernel.org with SMTP id S932384AbVI0MWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:22:49 -0400
Message-ID: <C75A388845B4B54B9CF5E2ADB589B0E30F389A86@btss005a.siemens-pse.sk>
From: Kormos Matej <Matej.Kormos@siemens.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Sys fs
Date: Tue, 27 Sep 2005 14:22:47 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
As far as I know all network drivers are automatically shown in
/sys/class/net;
But what to do if I want my kobject which is in my char driver appears in
/sys/class/net?
I am writing char driver which control some features on a switching device.
My kobject appears in directly in /sys directory because I set kobject
parent and kset to NULL.
But I need to move it to the net directory. I have read the book Linux
Device Drivers and searched web, but I have not found way how to acquire
pointers to ksets created by another drivers and how to connect to net
class. 

Thanks  for all suggestions.
