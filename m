Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbSLEVRQ>; Thu, 5 Dec 2002 16:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267473AbSLEVQZ>; Thu, 5 Dec 2002 16:16:25 -0500
Received: from [81.2.122.30] ([81.2.122.30]:1540 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267472AbSLEVPj>;
	Thu, 5 Dec 2002 16:15:39 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212052134.gB5LYaeT000200@darkstar.example.net>
Subject: X locks console using /dev/null as core pointer
To: linux-kernel@vger.kernel.org
Date: Thu, 5 Dec 2002 21:34:36 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting X with /dev/null configured as a PS/2 mouse locks the
console.

Killing X from a serial terminal didn't fix the console - not even
numlock was working.

I guess this is really an X bug, but should it lock the console hard,
so that it's not even possible to switch VTs?

John.
