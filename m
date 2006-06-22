Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbWFVSrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWFVSrF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWFVSrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:47:04 -0400
Received: from gw.goop.org ([64.81.55.164]:59098 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751639AbWFVSrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:47:03 -0400
Message-ID: <449AE5B3.8050609@goop.org>
Date: Thu, 22 Jun 2006 11:47:15 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Eduard-Gabriel Munteanu <maxdamage@aladin.ro>
CC: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: CPUFreq ability to overclock
References: <449B0DC0.8070203@aladin.ro>
In-Reply-To: <449B0DC0.8070203@aladin.ro>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard-Gabriel Munteanu wrote:
>  I've seen a comment about scaling voltages in cpufreq.c, but it seems 
> there is no actual support for that. 

Cpufreq operates in terms of "operating points" which are 
voltage/frequency pairs, rather than just voltages.  All the CPU drivers 
which support it have a voltage corresponding to each frequency to make 
an operating point.

    J
