Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbTEaHKT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 03:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbTEaHKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 03:10:19 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:8832
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264183AbTEaHKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 03:10:18 -0400
Date: Sat, 31 May 2003 03:13:20 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
cc: linux-kernel@vger.kernel.org
Subject: RE: RFC Proposal to enable MSI support in Linux kernel
In-Reply-To: <1054306504.7890.5.camel@ulysse.olympe.o2t>
Message-ID: <Pine.LNX.4.50.0305310310530.31414-100000@montezuma.mastecende.com>
References: <1054306504.7890.5.camel@ulysse.olympe.o2t>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003, Nicolas Mailhot wrote:

> Hi,
> 
> 	Before you say all's well in linux 2.5 edge/level APIC processing take
> a look at:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=10
> 
> (not that I know if it's actually closely related to this thread, but
> for once there is an APIC guru gathering on linux-kernel...)

It doesn't appear to be a edge/level trigger issue, i've posted a comment 
regarding the possible cause (lack of an MADT causes ACPI to make wrong 
decision with respect to interrupt controller type). There was a report a 
couple of weeks back with what appears to be the same symptoms.

	Zwane
-- 
function.linuxpower.ca
