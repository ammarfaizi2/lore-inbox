Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbULKSJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbULKSJx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 13:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbULKSJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 13:09:52 -0500
Received: from [81.3.11.18] ([81.3.11.18]:55959 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S261990AbULKSJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 13:09:51 -0500
Date: Sat, 11 Dec 2004 19:09:46 +0100
From: Konstantin Kletschke <konsti@ku-gbr.de>
To: linux-kernel@vger.kernel.org
Subject: Re: How do klogd and syslogd influence code execution timing?
Message-ID: <20041211180946.GA9409@ku-gbr.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041210152107.GA23594@synertronixx3> <20041210162623.1c749f58.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210162623.1c749f58.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2004-12-10 16:26 -0800 schrieb Andrew Morton:
> 
> The difference is that if klogd is running, a printk() will cause a wakeup

Hm, good that I asked. I know now, the difference is the _running_
klogd...

> to go into the scheduler code, take and release locks, take more time, etc.

scheduler code... take/release locks... I think that works around a Bug
or problem we have in our driver code...
But I will have to search for it since I am a greenhorn in writing
device drivers and locking/protecting critical sections :)

Regards, Konsti

-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
