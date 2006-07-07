Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWGGTTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWGGTTz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWGGTTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:19:55 -0400
Received: from gherkin.frus.com ([192.158.254.49]:40717 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S932264AbWGGTTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:19:53 -0400
Subject: 2.6.18-rc1 build error (YACC)
To: linux-kernel@vger.kernel.org
Date: Fri, 7 Jul 2006 14:19:52 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20060707191952.81958DBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$YACC now seems to be undefined when I do a "make bzImage" and the
build process gets to drivers/scsi/aic7xxx/aicasm (with the aic7xxx
driver configured as a built-in).  As a workaround, it's possible to
"cd" into the indicated directory and run "make" directly.  Once the
default build completes, restarting "make bzImage" from the kernel
source root continues as expected.

This problem did not exist with 2.6.17.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
