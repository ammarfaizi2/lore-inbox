Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTEUQZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 12:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTEUQZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 12:25:10 -0400
Received: from mx1.mail.ru ([194.67.23.21]:32523 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262195AbTEUQZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 12:25:09 -0400
Date: Wed, 21 May 2003 23:38:04 +0700
From: Anton Petrusevich <casus@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: e100 & 2.4.20
Message-ID: <20030521163804.GA7957@casus.home.my>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an updated RedHat kernel for rh72, with
Intel(R) PRO/100 Network Driver - version 2.2.21-k1
Copyright (c) 2003 Intel Corporation

 What I see from dmesg:

PCI: Found IRQ 11 for device 01:03.0
e100: selftest OK.
divert: allocating divert_blk for eth0
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

PCI: Found IRQ 11 for device 01:04.0
e100: selftest OK.
divert: allocating divert_blk for eth1
e100: eth1: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

e100: eth0 NIC Link is Up 100 Mbps Full duplex
hw tcp v4 csum failed
(repeated many times):hw tcp v4 csum failed

I just don't like it. Is it a known problem with e100?

-- 
Anton Petrusevich

