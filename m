Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbTHUNnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 09:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbTHUNnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 09:43:12 -0400
Received: from law14-f46.law14.hotmail.com ([64.4.21.46]:17427 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262666AbTHUMru
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 08:47:50 -0400
X-Originating-IP: [194.85.81.178]
X-Originating-Email: [john_r_newbie@hotmail.com]
From: "John Newbie" <john_r_newbie@hotmail.com>
To: sneakums@zork.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maybe remove request_module("scsi_hostadapter"); from ->
Date: Thu, 21 Aug 2003 16:47:48 +0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law14-F46r7An1P78E00005323d@hotmail.com>
X-OriginalArrivalTime: 21 Aug 2003 12:47:49.0104 (UTC) FILETIME=[6D54A700:01C367E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Consider IDE systems with SCSI peripherals and SCSI built modular.

In my opinion the best solution is to surround
request_module("scsi_hostadapter");
with
#ifdef CONFIG_SCSI_MODULE
in addition to CONFIG_KMOD

Agree?

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

