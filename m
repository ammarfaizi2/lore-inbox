Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269351AbTGJPeq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269353AbTGJPeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:34:46 -0400
Received: from f9.mail.ru ([194.67.57.39]:10770 "EHLO f9.mail.ru")
	by vger.kernel.org with ESMTP id S269351AbTGJPep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:34:45 -0400
From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
To: linux-kernel@vger.kernel.org
Cc: skraw@ithnet.com
Subject: 2.4.22-pre3 and reiserfs boot problem
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [81.89.69.194]
Date: Thu, 10 Jul 2003 19:49:20 +0400
Reply-To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= 
	  <ia6432@inbox.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19adfc-000Cax-00.ia6432-inbox-ru@f9.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am not on the list so please CC me if replying...

I've found the problem, it's patch with description:

Fix potential IO hangs and increase interactiveness during heavy IO

http://linux.bkbits.net:8080/linux-2.4/user=mason/cset@1.1024?nav=!-|index.html|stats|!+|index.html|ChangeSet@-7d

After removing all changes from this cset, a had no problems
mounting big reiserfs volumes...

