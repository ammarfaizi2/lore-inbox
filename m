Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263548AbUDBBs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUDBBsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:48:25 -0500
Received: from imap.gmx.net ([213.165.64.20]:59329 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263548AbUDBBsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:48:02 -0500
X-Authenticated: #1892127
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <87456E3F-8450-11D8-91A9-0003931E0B62@gmx.li>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Martin Schaffner <schaffner@gmx.li>
Subject: [PATCH 2.6.5-rc3] enable compilation on hosts without elf.h
Date: Fri, 2 Apr 2004 03:50:40 +0100
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://membres.lycos.fr/schaffner/non-elf-host.patch

To compile linux, a host currently has to provide elf.h.

The following patch removes this necessity by adding elf.h from 
glibc-2.3.2 (minus the inclusion of features.h) to scripts/:

http://membres.lycos.fr/schaffner/non-elf-host.patch

--
Martin

