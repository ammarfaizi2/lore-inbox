Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269299AbTGMPUm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 11:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269634AbTGMPUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 11:20:42 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:51460 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S269299AbTGMPUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 11:20:41 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Avoiding "unused variable" warnings
Date: Sun, 13 Jul 2003 19:32:23 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307131932.24015.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I have seen it somewhere but forgot.

Is it possible to create a noop macro that makes compiler believe macro 
arguments are used? I mean the case of debug macro that for debug off is 
redefined as something like do { } while(0) but then if arguments are used 
for debugging purposes only compiler emits warning. Some people do not like 
it :)

TIA

-andrey
