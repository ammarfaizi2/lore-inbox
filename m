Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264792AbTGCPwV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 11:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264780AbTGCPwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:52:21 -0400
Received: from web20407.mail.yahoo.com ([66.163.169.95]:21056 "HELO
	web20419.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264754AbTGCPwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:52:13 -0400
Message-ID: <20030703160638.40487.qmail@web20419.mail.yahoo.com>
Date: Thu, 3 Jul 2003 09:06:38 -0700 (PDT)
From: devnetfs <devnetfs@yahoo.com>
Subject: compiling with -g changes symbol addresses
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry if this is NOT related to kernel per se. but...

Compiling a kernel module with and without "-g" gcc flag, 
(rest of the compiler flags remaining exactly the same/usual) 
changes the offsets/addresses of some (not all) symbols 
[saw using nm(1)].

Is this normal? I thought "-g" just adds debug info into the object
file. and it should not change the offsets/addresses that
symbols get assigned during compilation.

btw I am using gcc 2.96 (from RH).

Thanks
A.
[Pleas Cc: me the reply]

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
