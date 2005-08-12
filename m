Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVHLXOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVHLXOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 19:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVHLXOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 19:14:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28149 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751304AbVHLXOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 19:14:07 -0400
Message-ID: <42FD2D18.6080302@mvista.com>
Date: Fri, 12 Aug 2005 16:13:28 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 1.0+ (X11/20050531)
MIME-Version: 1.0
To: Jordan Crouse <jordan.crouse@amd.com>
CC: Dave Jones <davej@redhat.com>, Bruno Ducrot <ducrot@poupinou.org>,
       Pavel Machek <pavel@ucw.cz>, cpufreq@lists.linux.org.uk,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Re: PowerOP 2/3: Intel Centrino support
References: <20050809025419.GC25064@slurryseal.ddns.mvista.com> <20050810100133.GA1945@elf.ucw.cz> <20050810125848.GM852@poupinou.org> <20050810184445.GB14350@redhat.com> <42FA8FC0.5000700@mvista.com> <20050811150650.GG26524@cosmic.amd.com>
In-Reply-To: <20050811150650.GG26524@cosmic.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Crouse wrote:

> When it comes
> to embedded power management concepts, a consistant theme is that people
> often question the usefulness, redundancy or complexity of a solution.  This
> is perfectly understandable, since such a huge majority of the power
> management experts and users are concentrating intently on x86 desktops and
> servers.  

It also occurs to me that another reason for the disconnect between x86 
desktop/server and embedded on this point is the lack of ACPI.  We want 
to do things analogous to the power management performed by ACPI, but 
entirely in Linux, so we need to expose some of those low-level machine 
resources to our power management software.  In many cases those power 
management decisions do not revolve around the question of the MHz at 
which the CPU is to run.  Embedded Linux system power management exists 
for many of the same reasons ACPI exists.


-- 
Todd
