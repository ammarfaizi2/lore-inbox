Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUGYQyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUGYQyu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 12:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUGYQyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 12:54:50 -0400
Received: from wingding.demon.nl ([82.161.27.36]:50819 "EHLO wingding.demon.nl")
	by vger.kernel.org with ESMTP id S264002AbUGYQyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 12:54:49 -0400
Date: Sun, 25 Jul 2004 18:54:47 +0200
From: Rutger Nijlunsing <rutger@nospam.com>
To: Riccardo Vestrini <riccardov@sssup.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is it really better speedstep-ich vs. p4-clockmod cpufreq driver?
Message-ID: <20040725165447.GA16349@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <41015EEF.3070602@sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41015EEF.3070602@sssup.it>
Organization: M38c
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 08:54:39PM +0200, Riccardo Vestrini wrote:
> it seems that speedstep-ich and acpi cpufreq driver have only two usable
> clock frequencies, while p4-clockmod has eight
> my cpu is: Intel Mobile Intel(R) Pentium(R) 4   CPU 3.06GHz stepping 09
> 
[snip]
> 
> i do not know what driver is supposed to be better and why speedstep-ich 
> driver has only two frequencies

p4-clockmod is not really a cpufreq driver: it does not change the
frequency. The only function is to have 'idle-cycles' to cool down the
processor during intensive CPU programs: this is what the processor
does when it gets too hot.

The speedstep driver _does_ change the frequency (and/or voltage) and
gives other advantages like less power consumption.

So use speedstep.

-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
