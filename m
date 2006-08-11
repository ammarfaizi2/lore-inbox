Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWHKTlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWHKTlK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWHKTlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:41:10 -0400
Received: from rtr.ca ([64.26.128.89]:55755 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932251AbWHKTlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:41:09 -0400
Message-ID: <44DCDD50.4020804@rtr.ca>
Date: Fri, 11 Aug 2006 15:41:04 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
References: <44DCCB96.5080801@rtr.ca> <20060811183954.GH26930@redhat.com>
In-Reply-To: <20060811183954.GH26930@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> boot with cpufreq.debug=7, and capture dmesg output after it fails
> to transition.  This might be another manifestation of the mysterious
> "highest frequency isnt accessable" bug, that seems to come from
> some recent change in acpi.

booting with that option doesn't seem to give me any new messages
in dmesg (or /var/log/messages).  I also tried editing cpufreq.c
and hardcoding debug = 7 on the variable declaration.
Still no new messages.

??
