Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbUKRO6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUKRO6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 09:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUKRO4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 09:56:09 -0500
Received: from mail.aknet.ru ([217.67.122.194]:36358 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262360AbUKROyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 09:54:39 -0500
Message-ID: <419CB7D4.9050303@aknet.ru>
Date: Thu, 18 Nov 2004 17:55:16 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: prasanna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
References: <20041109130407.6d7faf10.akpm@osdl.org> <20041110104914.GA3825@in.ibm.com> <4192638C.6040007@aknet.ru> <20041117131552.GA11053@in.ibm.com>
In-Reply-To: <20041117131552.GA11053@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Prasanna S Panchamukhi wrote:
> Yes, there is a small bug in kprobes. Kprobes int3 handler
> was returning wrong value. Please check out if the patch
> attached with this mail fixes your problem.
The patch is tested and works - thanks.

