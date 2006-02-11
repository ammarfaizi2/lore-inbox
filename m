Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWBKViD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWBKViD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 16:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWBKViD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 16:38:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26284 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964799AbWBKViB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 16:38:01 -0500
Date: Sat, 11 Feb 2006 16:37:48 -0500
From: Dave Jones <davej@redhat.com>
To: Nico Golde <nico@ngolde.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Getting cpu frequency
Message-ID: <20060211213748.GD8337@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nico Golde <nico@ngolde.de>, linux-kernel@vger.kernel.org
References: <20060211204733.GA7813@ngolde.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060211204733.GA7813@ngolde.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 09:47:34PM +0100, Nico Golde wrote:
 > Hi,
 > at the moment I try to get the current cpu frequency via 
 > using the cpufreq_get() function defined in linux/cpufreq.h.
 > Can someone point me to the headers I have to include to let 
 > this work because just doing #include <linux/cpufreq.h> 
 > results in a bunch of errors:
 > [...] 
 > In file included from /usr/include/linux/cpu.h:22,
 >                  from cpu.c:2:
 > /usr/include/linux/sysdev.h:31: error: field 'drivers' has incomplete type
 > /usr/include/linux/sysdev.h:35: error: syntax error before 'pm_message_t'
 > /usr/include/linux/sysdev.h:37: error: field 'kset' has incomplete type
 > /usr/include/linux/sysdev.h:50: error: field 'entry' has incomplete type
 > /usr/include/linux/sysdev.h:54: error: syntax error before 'pm_message_t'
 > /usr/include/linux/sysdev.h:69: error: syntax error before 'u32'
 > /usr/include/linux/sysdev.h:72: error: syntax error before '}' token
 > /usr/include/linux/sysdev.h:79: error: field 'attr' has incomplete type
 > /usr/include/linux/sysdev.h:80: error: syntax error before 'ssize_
 > [...] 
 > Using 2.6.14.
 > Regards Nico
 > P.S. Please CC me, I am not subsribed, thanks

Are you trying to do this from a userspace program ?
If so, this isn't going to work.

		Dave


