Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265618AbUABR3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 12:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265619AbUABR3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 12:29:51 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:62647 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S265618AbUABR3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 12:29:49 -0500
Message-ID: <3FF5AA95.6040306@arcor.de>
Date: Fri, 02 Jan 2004 18:29:57 +0100
From: Thomas Meyer <thomas.mey3r@arcor.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-rc1-mm1: via-rhine.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i tried to use kgdb over ethernet, but when using the tool ifconfig, or 
dhcpcd all i get back is:
  -> "SIOCSIFFLAGS: Device or resource busy"

Two things i notived:
KGDB_stub holds interrupt 4,
the via-rhine driver holds no interrupt!

2.6.0-mm2 also fails, 2.6.0-mm1 worked (with net_poll patch in via_rhine.c)

with kind regards
thomas meyer

