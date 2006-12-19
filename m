Return-Path: <linux-kernel-owner+w=401wt.eu-S932722AbWLSJiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbWLSJiE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWLSJiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:38:04 -0500
Received: from blaster.systems.pipex.net ([62.241.163.7]:44957 "EHLO
	blaster.systems.pipex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932721AbWLSJiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:38:03 -0500
X-Greylist: delayed 1621 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 04:38:03 EST
Date: Tue, 19 Dec 2006 09:10:25 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@ws.homenet
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] microcode: Fix mc_cpu_notifier section warning
In-Reply-To: <20061219083328.5951571f.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.61.0612190909030.7347@ws.homenet>
References: <20061217173602.abaf4b69.khali@linux-fr.org>
 <Pine.LNX.4.61.0612180954380.3848@ws.homenet> <20061219083328.5951571f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On Tue, 19 Dec 2006, Jean Delvare wrote:
> I don't see anything in arch/i386/kernel/microcode.c depending on
> CONFIG_HOTPLUG_CPU (in 2.6.20-rc1), sorry.

I run 2.6.19.1 and there both mc_cpu_notifier (which your patch modified) 
and mc_cpu_callback (which uses mc_cpu_notifier) are inside #ifdef 
CONFIG_HOTPLUG_CPU.

Kind regards
Tigran
