Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbTGONv2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 09:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267844AbTGONtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 09:49:16 -0400
Received: from mail.siemenscom.com ([12.146.131.10]:38807 "EHLO
	mail.siemenscom.com") by vger.kernel.org with ESMTP id S267783AbTGONsh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 09:48:37 -0400
Message-ID: <7A25937D23A1E64C8E93CB4A50509C2A0179B6E2@stca204a.bus.sc.rolm.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: linux-kernel@vger.kernel.org
Subject: Driver poll method
Date: Tue, 15 Jul 2003 07:03:23 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am implementing a poll method in a driver. I have defined a queue which I
put into a wait table with a call to poll_wait. I also have my own DMA input
list which is very specific to my device. I want my application to sleep in
a suspended state until my device writes some data into the input list. Is
it not so that the Kernel should periodically call my poll routine after my
application calls select (until the select timer expires or as in my case, I
specify a NULL value for the timeout). Please CC me directly on any
responses.

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com

