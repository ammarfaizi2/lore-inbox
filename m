Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTLDNuf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 08:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTLDNuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 08:50:35 -0500
Received: from main.gmane.org ([80.91.224.249]:28077 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262076AbTLDNud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 08:50:33 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [Oops] ACPI problem with 2.6.0-test11 on Asus L3800C
Date: Thu, 04 Dec 2003 14:50:29 +0100
Message-ID: <yw1xekvkvgii.fsf@kth.se>
References: <200312041434.56759@marsupilami.global-thinking.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:ULdRo1KLeIkgxxEP5IdwCyhgBfo=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gümbel <david.guembel@gmx.de> writes:

> [Please CC me, as I am not subscribed to this list]
>
> I have recently installed 2.6.0-test11 on my Asus L3800C laptop. One thing I 
> stumbled across was that it is no longer possible to set the CPU 
> performance via ACPI. It worked fine with 2.4.21 with acpi-patch applied.
> The behaviour is reproducible, i.e. it happens every time I try to set the 
> performance. Symptoms are as follows:
>
> When executing 'echo 1 > /proc/acpi/processor/CPU0/performance', I got the 
> following (visible via dmesg):

The standard method of changing CPU frequency in Linux 2.6 is the
cpufreq interface in /sys/devices/system/cpu/cpu0/cpufreq/*.  This may
not solve your problem, of course.

-- 
Måns Rullgård
mru@kth.se

