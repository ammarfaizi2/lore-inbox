Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267290AbUBSOny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267217AbUBSOmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:42:11 -0500
Received: from smtp-gw.fnbs.net.my ([202.9.108.191]:25868 "EHLO
	smtp-gw.fnbs.net.my") by vger.kernel.org with ESMTP id S267290AbUBSOlG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:41:06 -0500
Subject: Security update patch to 2.6.3 for mremap()?
From: Nur Hussein <obiwan@slackware.org.my>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1077201466.1636.19.camel@sophia.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 19 Feb 2004 22:37:46 +0800
Content-Transfer-Encoding: 7bit
X-Rcpt-To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
                                                                                                                             I was searching the source and changelogs of 2.6.3 to find the specific
patch that fixed the recent security hole discovered in mremap()
 
http://isec.pl/vulnerabilities/isec-0014-mremap-unmap.txt
                                                                                                                             I found Andrew Morton's changelog entry that touched mremap:
 
http://linux.bkbits.net:8080/linux-2.5/cset@1.1557.2.83?nav=index.html|ChangeSet@-2d
                                                                                                                             I noticed however, that a fix to the same problem in 2.4.25 sent by
Andrea Arcangeli adds only one line to a different section of code:
 
http://linux.bkbits.net:8080/linux-2.4/diffs/mm/mremap.c@1.7?nav=cset@1.1136.94.4
                                                                                                                             Is this line missing from 2.6.3, or did Andrew Morton's fixes address
the problem already?
 
-= Nur Hussein =-


