Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVAKN6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVAKN6Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 08:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVAKN6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 08:58:25 -0500
Received: from www.linux4media.com ([213.133.97.116]:12253 "EHLO archimedis.tv")
	by vger.kernel.org with ESMTP id S262760AbVAKN6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 08:58:23 -0500
From: Bernhard Rosenkraenzer <bero@linux4media.com>
Organization: LINUX4MEDIA GmbH
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-mm2 fails to detect DVD drive on Asus Pundit, 2.6.10-ac8 works
Date: Tue, 11 Jan 2005 14:55:30 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501111455.30978.bero@linux4media.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SSIA -- I haven't seen this problem on any other hardware though, looks like 
Asus is doing something weird in its controller and -mm doesn't have a 
workaround.

The IDE controller appears to be a variant of a SiS 5513 (one oddity is the 
fact that there is no secondary controller). The harddisk is connected 
as /dev/hda, the DVD drive as /dev/hdb. Using a different DVD drive doesn't 
change anything.

Unless someone beats me to it, I'll diff -u the -ac8 and -mm2 IDE drivers to 
figure out what's going on when I have some time.

LLaP
bero
