Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTI3KSR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 06:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTI3KSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 06:18:17 -0400
Received: from mail.g-housing.de ([62.75.136.201]:7060 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261328AbTI3KSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 06:18:16 -0400
Message-ID: <3F795816.7050805@g-house.de>
Date: Tue, 30 Sep 2003 12:16:54 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030914 Thunderbird/0.3a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ERR in /proc/interrupts
References: <slrnbnijq7.41m.usenet.2117@home.andreas-s.net>
In-Reply-To: <slrnbnijq7.41m.usenet.2117@home.andreas-s.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwarz wrote:
> I get a very high ERR count in /proc/interrupts. If I move my USB mouse
> the number increases.
> 
> What does ERR mean? Nothing good, I suppose?
> 

../Documentation/filesystems/proc.txt says:

ERR is incremented in the case of errors in the IO-APIC bus (the bus 
that connects the CPUs in a SMP system. This means that an error has 
been detected, the IO-APIC automatically retry the transmission, so it 
should not be a big problem, but you should read the SMP-FAQ.

Christian, knowing nothing more than this too :-)

