Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265100AbUEMV1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUEMV1K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 17:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265122AbUEMV1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 17:27:10 -0400
Received: from outmx014.isp.belgacom.be ([195.238.2.69]:13487 "EHLO
	outmx014.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265100AbUEMV1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 17:27:07 -0400
Subject: [ OFFTOPIC & trivial ] spinlock & atomic
From: FabF <Fabian.Frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1084285268.12321.6.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 11 May 2004 16:21:08 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx014.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Someone could explain why we have following code in kernel ?

spinlock (x)
atomic_inc (x->y)
spinunlock(x)

	I mean y being part of x should be atomically modified with a "normal"
operation ? What am I missing ? Does it mean we defined y atomic_t in
order to have atomic operations elsewhere without the lock held ? Simply
?

Regards,
FabF

