Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTLCERD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 23:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264497AbTLCERD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 23:17:03 -0500
Received: from rrcs-west-24-199-16-170.biz.rr.com ([24.199.16.170]:17101 "EHLO
	ns1.silvex.com") by vger.kernel.org with ESMTP id S264493AbTLCERB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 23:17:01 -0500
Message-ID: <45084.12.9.207.208.1070424568.squirrel@24.199.16.170>
Date: Tue, 2 Dec 2003 20:09:28 -0800 (PST)
Subject: Red Hat AS 2.1 crash.
From: "Eduardo E. Silva" <esilva@silvex.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0-1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, while mousing around we ran a command

find / -type f -exec grep pass {} \;

on a Red Hat Advanced Server 2.1 using kernel  2.4.9-e.12smp based rpm from
Red Hat. Well the machine panic when grep hit /proc/kmsg.

I ran the same command on a machine with a later kernel  2.4.9-e.30smp
withour panicing the machine. Although it hung up in the /proc/kmsg.

Has this been a confirmed bug ?



-- 
Thanks,

Ed Silva
Silvex Consulting Inc.
esilva@silvex.com
(714) 504-6870 Cell
(714) 897-3800 Fax

