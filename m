Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbULEX0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbULEX0I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbULEX0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:26:08 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:22417 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261305AbULEX0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:26:04 -0500
To: Thomas Bettler <bettlert@student.ethz.ch>, linux-kernel@vger.kernel.org
Subject: Re: cpufreq: shouldn't scaling_min_freq be lower?
In-Reply-To: <200412052306.07460.bettlert@student.ethz.ch>
References: <200412052306.07460.bettlert@student.ethz.ch>
Date: Sun, 5 Dec 2004 23:26:03 +0000
Message-Id: <E1Cb5lT-0007vk-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Bettler <bettlert@student.ethz.ch> wrote:

> In the beginning there was a Windoze on it. The cpufreq varied from 1800 to 
> 120MHz

Windows tends to use a combination of CPU scaling and throttling to get
the processor that slow. Take a look at
/proc/acpi/processor/*/throttling

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
