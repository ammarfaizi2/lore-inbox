Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264797AbTFCBAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 21:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264841AbTFCBAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 21:00:43 -0400
Received: from smtpout.mac.com ([17.250.248.89]:44023 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S264797AbTFCBAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 21:00:38 -0400
Date: Tue, 3 Jun 2003 11:13:33 +1000
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: CRC32=y && 8193TOO=m unresolved symbols
From: Stewart Smith <stewartsmith@mac.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <985F0B02-9560-11D7-968C-00039346F142@mac.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this problem disappears when you have CONFIG_CRC32=y and 
CONFIG_8139TOO=y. It only happens when CRC32=y and 8139TOO=m

Occurs on all 2.5.70 through bk6 (haven't tried later). Also on -mm3

I get unresolved symbols for bitreverse and crc32_le.

I've tried mucking around a bit with EXPORT_SYMBOL and the like, but I 
have to admit, i'm stumped. Help! :)
------------
Stewart Smith
Vice President, Linux Australia
stewart@linux.org.au
http://www.linux.org.au

