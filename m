Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTLPKwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 05:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTLPKwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 05:52:06 -0500
Received: from mail.mediaways.net ([193.189.224.113]:15855 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S261368AbTLPKwE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 05:52:04 -0500
Subject: essid any -> orinoco_lock() called with hw_unavailable -test11
From: Soeren Sonnenburg <kernel@nn7.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1071571879.2498.65.camel@localhost>
Mime-Version: 1.0
Date: Tue, 16 Dec 2003 11:51:20 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I get quiete many error messages in when I do

ifconfig eth1 192.168.0.1 up
iwconfig eth1 mode ad-hoc
iwconfig eth1 nick bla
iwconfig eth1 key off
iwconfig eth1 essid "any"
ifconfig eth1 down

and no wireless network is available. The device is no longer accessible
afterwards. Reloading kernel modules helps, however if I go to sleep
mode on this 1GHz 15" G4 Powerbook the machine hangs on resume, see

http://www.nn7.de/kernel/essid_any.jpg

for the messages and xmon trace (please use a webbrowser to view it, it
is a redirect)

Soeren.

