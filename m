Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030573AbVIOVlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030573AbVIOVlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbVIOVlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:41:21 -0400
Received: from main.gmane.org ([80.91.229.2]:27863 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030573AbVIOVlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:41:20 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jakub Piotr Clapa <jpc@pld-linux.org>
Subject: Re: [ACPI] wrong documentation for /proc/acpi/sleep?
Date: Thu, 15 Sep 2005 23:25:52 +0200
Message-ID: <dgcot5$vm6$1@sea.gmane.org>
References: <87mzme3xv8.fsf@echidna.jochen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: jpc.one.pl
User-Agent: Thunderbird 1.4 (X11/20050908)
In-Reply-To: <87mzme3xv8.fsf@echidna.jochen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Hein wrote:
> The documentation in Documentation/power/swsusp.txt reads:
> 
> ,----
> | Sleep states summary
> | ====================
> | 
> | There are three different interfaces you can use, /proc/acpi should
> | work like this:
> | 
> | In a really perfect world:
> | echo 1 > /proc/acpi/sleep       # for standby
> | echo 2 > /proc/acpi/sleep       # for suspend to ram
> | echo 3 > /proc/acpi/sleep       # for suspend to ram, but with more
> | power conservative
> | echo 4 > /proc/acpi/sleep       # for suspend to disk
> | echo 5 > /proc/acpi/sleep       # for shutdown unfriendly the system
> | 
> | and perhaps
> | echo 4b > /proc/acpi/sleep      # for suspend to disk via s4bios
> `----
> 
> I do get:
> root@hermes:~# echo 2 > /proc/acpi/sleep
> bash: /proc/acpi/sleep: No such file or directory

Try 'cat /sys/power/state' and then echo one of the keywords back to 
this file.

-- 
Regards,
Jakub Piotr Cłapa

