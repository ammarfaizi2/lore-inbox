Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbVJTVSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVJTVSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 17:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVJTVSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 17:18:51 -0400
Received: from easyspace2.ezspl.net ([66.45.254.2]:34192 "EHLO
	easyspace2.ezspl.net") by vger.kernel.org with ESMTP
	id S932526AbVJTVSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 17:18:51 -0400
Subject: running linux TCP/IP stack on a real slow machine
From: Kallol Biswas <kallol@nucleodyne.com>
Reply-To: kallol@nucleodyne.com
To: linux-kernel@vger.kernel.org
In-Reply-To: <20051020135014.2289fa01.akpm@osdl.org>
References: <871x2gf8f5.fsf@devron.myhome.or.jp>
	 <20051020135014.2289fa01.akpm@osdl.org>
Content-Type: text/plain
Organization: NucleoDyne Systems Inc.
Message-Id: <1129842512.24889.21.camel@driver>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 20 Oct 2005 14:08:32 -0700
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - easyspace2.ezspl.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - nucleodyne.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been designing and developing IP cores for a system on chip
project. A system emulator (RTL) has been used to validate the cores.
The emulated system runs at several Khz (700KHz) and is real slow.
Booting linux takes more that 40 minutes. We have a bridge for the
ethernet interface to talk to outside network, and it does not terminate
TCP connections.

If a process running on such a system tries to talk a process that is
running on a normal system (like a PC) over TCP/IP protocols what will
be the issues we will find in the stack?

I have a good idea on what is going to happen. Just looking for
comments/input.

Kallol Biswas

