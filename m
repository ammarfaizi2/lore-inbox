Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWI2JqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWI2JqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWI2JqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:46:25 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:24276 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750764AbWI2JqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:46:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZEmJLqpCjGwTAp2B37st/8jp0vJDgnCfn1AyPhbxmG0DqYA5/HKPGooyqqBhWZH1X+i1jWUzDgsdziaAluCR3gk0npnmS5YR5A+uE0DeqnIQrahCKMK/D3UNETAn6KuA3qkEUmcLel2op7lBvWxtSYJdqZHgdTUhA64w67sZ9jc=
Message-ID: <a44ae5cd0609290246w646ad782h4078f59dcbd1ad14@mail.gmail.com>
Date: Fri, 29 Sep 2006 02:46:22 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       cpufreq@lists.linux.org.uk
Subject: Re: 2.6.18-mm1 -- CPUFreq not working
In-Reply-To: <a44ae5cd0609261051i6dc03777l6646899624a62d5a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0609261051i6dc03777l6646899624a62d5a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am wondering whether the following warning indicates a problem that
> prevents CPUFreq from working, because no matter how I play with the
> CPUFreq kernel config options, I always get a message from the power
> management applet that CPUFreq isn't working.
> WARNING: arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.o - Section
> mismatch: reference to .init.data:sw_any_bug_dmi_table from .text
> between 'acpi_cpufreq_cpu_init' (at offset 0x360) and
> 'acpi_cpufreq_target'
> WARNING: arch/i386/kernel/cpu/cpufreq/speedstep-centrino.o - Section
> mismatch: reference to .init.text: from .data between
> 'sw_any_bug_dmi_table' (at offset 0x40) and 'models

With 2.6.18-git11, I still get this one:
WARNING: drivers/acpi/processor.o - Section mismatch: reference to
.init.data: from .text between 'acpi_processor_power_init' (at offset
0xf4f) and 'acpi_safe_halt'
