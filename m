Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269432AbUICJsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269432AbUICJsy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269476AbUICJsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:48:10 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:58498 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S269605AbUICJo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:44:59 -0400
Message-ID: <41383D02.5060709@drzeus.cx>
Date: Fri, 03 Sep 2004 11:44:34 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: HP/Compaq (Winbond) SD/MMC reader supported
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since most people will search the LKML for drivers I'll post this little 
notice so people can find it.

The Winbond W83L519D SD/MMC card reader found in many of HP/Compaq's 
laptops (x1000, nx7000, nx7010, etc.) can now be used in Linux. The 
driver is still in its early stages and not ready for inclusion in the 
main kernel. But for those brave enough to fiddle around the driver can 
do both reads and writes. The only known problem is that it doesn't like 
some cards (they do not get past the init. so no risk of data loss).

The project web page is at:

http://projects.drzeus.cx/wbsd/

Please post your results on the development mailing list there.

Rgds
Pierre Ossman

