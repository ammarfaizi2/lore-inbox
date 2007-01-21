Return-Path: <linux-kernel-owner+w=401wt.eu-S1751041AbXAUCOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbXAUCOp (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 21:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbXAUCOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 21:14:45 -0500
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:3835 "EHLO
	smtp-vbr14.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbXAUCOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 21:14:44 -0500
Message-ID: <45B2CC89.1020305@xs4all.nl>
Date: Sun, 21 Jan 2007 03:14:33 +0100
From: Bauke Jan Douma <bjdouma@xs4all.nl>
Reply-To: bjdouma@xs4all.nl
Organization: a training zoo
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, osst@riede.org,
       osst-users@lists.sourceforge.net
Subject: OnStream DI30: undescriptive message: CoD != 0 in idescsi_pc_intr
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OnStream Di30 (using ide-scsi and osst drivers), when reading
or writing I regularly get these kernel messages:

<3>ide-scsi: CoD != 0 in idescsi_pc_intr

Let's assume flaky hardware; nothing we can hold the kernel to
blame for (which is 2.6.19.1) -- it's a good thing it's calling
our attention.  There's no data corruption, btw.

However, said message is quite useless because undescriptive
and too terse.


bjd



