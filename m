Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWEZOmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWEZOmF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWEZOmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:42:05 -0400
Received: from qb-out-0506.google.com ([72.14.204.224]:34341 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750822AbWEZOmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:42:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Bamd39HNIsrDfmdgLAvQFPg+ayKtBIDzmdv+Ah/LHsXFSHsFSMTE+vsXnXqZJ1N353v/VzVThG7XmgzelGMPE4FiGE6PC8RYOHzrso2EgGHtpTuoMn83NRA7ojUzzWIR1Ic1hkk3up+t73ETMsZo1CUy2q0yW6Xghgx4eGxj4mE=
Subject: [PATCH 0/2] tpm: bios log parsing fixes
From: Seiji Munetoh <seiji.munetoh@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kjhall@us.ibm.com, akpm@osdl.org, tpmdd-devel@lists.sourceforge.net
Content-Type: text/plain
Date: Fri, 26 May 2006 23:42:25 +0900
Message-Id: <1148654545.20195.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This following patch set fixes
PATCH 1/2 fix the eventlog parser to get the correct ASCII output, and
PATCH 2/2 changes the BINARY eventlog output format to the actual ACPI
log structure.

regards,
--
Seiji Munetoh

