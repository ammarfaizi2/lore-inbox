Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbVCQJFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbVCQJFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 04:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVCQJEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 04:04:44 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:39555 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261883AbVCQJEd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 04:04:33 -0500
Subject: [patch 0/2] fork_connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Ram <linuxram@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>
Date: Thu, 17 Mar 2005 10:03:55 +0100
Message-Id: <1111050235.306.106.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/03/2005 10:13:27,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/03/2005 10:13:55,
	Serialize complete at 17/03/2005 10:13:55
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  The following patch set adds a fork connector in the do_fork()
routine. 

  We provide two patches. The first one is the fork connector
implementation and the second one fix a bug in the connector.c. The
second patch has been sent by Evgeniy Polyakov for inclusion and should
be in the next -mm release. While it's not included, we provide it with
the fork connector to allow people to use and test the fork connector.

  Those patches apply to 2.6.11-mm4.

  I may not answer the questions before next Monday, sorry for the
delay.

Best regards,
Guillaume

