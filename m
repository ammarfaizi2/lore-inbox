Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUIPNS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUIPNS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268053AbUIPNSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:18:25 -0400
Received: from rose.man.poznan.pl ([150.254.173.3]:64390 "EHLO
	rose.man.poznan.pl") by vger.kernel.org with ESMTP id S268045AbUIPNQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:16:33 -0400
Message-ID: <41499348.46349103@man.poznan.pl>
Date: Thu, 16 Sep 2004 15:21:12 +0200
From: Gracjan Jankowski <gracjan@man.poznan.pl>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is there a limit on the amount of entries in /proc filesystem?
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The environment I work in is: SGI ProPack v2.2 for Linux, Kernel
2.4.20-sgi220r3 on an ia64.

When I intensively test my kernel module then more than 3100 entries in
/proc filesytem are created. When such number of entries is attained
then, even though create_proc_entry() and proc_mkdir() functions end
with success, the new files or directories don't appear in /proc
filesystm.

What is going wrong? Is there a limit on the amount of entries in /proc
filesystem? If yes, why the create_proc_entry() and proc_mkdir()
functions do not return NULL pointers?

As I'm not subscribed on this list, please set CC field in reply mail on
gracjan@man.poznan.pl

Thanks in advance.


Gracjan Jankowski
