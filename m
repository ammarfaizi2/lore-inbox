Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbVJREfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbVJREfR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 00:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbVJREfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 00:35:16 -0400
Received: from ns1.mcdownloads.com ([216.239.132.98]:43914 "EHLO
	mail.3gstech.com") by vger.kernel.org with ESMTP id S1751439AbVJREfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 00:35:15 -0400
Subject: 2.6.14-rc4-mm1: udev/sysfs wierdness
From: Aaron Gyes <floam@sh.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 17 Oct 2005 21:35:13 -0700
Message-Id: <1129610113.10504.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason this rule stopped working:

KERNEL=="event*", SYSFS{manufacturer}="Logitech", SYSFS{product}="USB
Receiver", NAME="input/mx1000", MODE="0644"

Did stuff in /sys/ change? Do I need to change all my rules to make up
for this? udevs fault? I do have the correct /dev/input/event0 node.

Aaron Gyes

