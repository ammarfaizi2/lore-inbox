Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVCYKCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVCYKCX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 05:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVCYKCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 05:02:23 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:24971 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261581AbVCYKCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 05:02:09 -0500
Subject: [patch 0/2] fork_connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Ram <linuxram@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
Date: Fri, 25 Mar 2005 11:01:56 +0100
Message-Id: <1111744917.687.47.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 25/03/2005 11:11:38,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 25/03/2005 11:11:39,
	Serialize complete at 25/03/2005 11:11:39
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  The following patch set adds a fork connector in the do_fork()
routine to 2.6.12-rc1-mm3 kernel. 

  We provide two patches. The first one is the fork connector
implementation and the second one fix a bug in the connector.c. The
second patch has been sent by Evgeniy Polyakov for inclusion and should
be in the next -mm release. While it's not included, we provide it with
the fork connector to allow people to use and test the fork connector.

  Those patches apply to 2.6.12-rc1-mm3.


Best regards,
Guillaume

