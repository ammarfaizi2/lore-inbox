Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264520AbTK0Nm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 08:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbTK0Nm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 08:42:57 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:41869 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S264520AbTK0Nm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 08:42:56 -0500
Date: Thu, 27 Nov 2003 14:42:45 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Simon <simon@highlyillogical.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test10] cpufreq: 2G P4M won't go above 1.2G - cpuinfo_max_freq too low
Message-ID: <20031127134245.GA9404@localhost>
References: <200311271139.07260.simon@highlyillogical.org> <20031127121801.GB9098@localhost> <200311271323.37123.simon@highlyillogical.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200311271323.37123.simon@highlyillogical.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At Thursday November 27th 2003 Simon wrote:

> Is there anything I can do about this apart from go back to 2.4 (I've grown to 
> like CONFIG_PREEMPT too much for that!) or run with the battery in all the 
> time? - I've a string of past laptops where the batteries only last 5 minutes 
> because of running with battery + ac power all the time, so I've been in the 
> habit of always removing it these days... - I've never had a problem running 
> it at max speed with 2.4.
 
Well running without battery might cause problems, why disable a fine
UPC when it's there. ;-)

> Seems that this is a fault of a better implementation of something... But 
> "better" to me shouldn't take away choice of cpu speed from the user? ;)

One last straw you might try, is building all the different cpufreq
drivers as modules, and trying if modprobeing one of them might work.
They seem to all behave slightly differently with respect to what they
assume to be true from the ACPI reported values, and what they try on
their own.
-- 
Marco Roeland
