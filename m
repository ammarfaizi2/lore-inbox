Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWIZRjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWIZRjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWIZRjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:39:53 -0400
Received: from sd291.sivit.org ([194.146.225.122]:58638 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S932175AbWIZRjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:39:52 -0400
Message-ID: <45195583.4090500@popies.net>
Date: Tue, 26 Sep 2006 18:29:55 +0200
From: Stelian Pop <stelian@popies.net>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Andrea Gelmini <gelma@gelma.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
References: <20060926135659.GA3685@jnb.gelma.net>
In-Reply-To: <20060926135659.GA3685@jnb.gelma.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Gelmini a écrit :
> Hi,
> 	I've got a Sony Vaio VGN-SZ1VP (dmidecode[1] and lspci[2]).
> 	Using default kernel (linux-image-2.6.15-27-686) of Ubuntu
> 	Dapper I've got /proc/acpi/sony/brightness and it works well
> 	(yes, Ubuntu drivers/char/sonypi.c is patched).
> 	With any other newer vanilla kernel, 2.6.15/16/17/18, /proc/acpi/sony
> 	doesn't appear, and it's impossibile to set brigthness, of
> 	course. Same thing with Ubuntu kernel package
> 	(linux-image-2.6.17-9-386).
> 	I tried to port Ubuntu sonypi.c patches to 2.6.18, but it doesn't
> 	work (I mean, it compiles clean, it "modprobes"[3] clean, but no
> 	/proc/acpi/sony/ directory).

/proc/acpi/sony comes from the sony_acpi driver, not sonypi.

You should get the latest sony_acpi driver, preferably from the -mm tree 
which hosts the most up to date version.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
