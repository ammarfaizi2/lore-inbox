Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTAUETW>; Mon, 20 Jan 2003 23:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbTAUETW>; Mon, 20 Jan 2003 23:19:22 -0500
Received: from franka.aracnet.com ([216.99.193.44]:5000 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261486AbTAUETW>; Mon, 20 Jan 2003 23:19:22 -0500
Date: Mon, 20 Jan 2003 20:28:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andy Grover <agrover@groveronline.com>, linux-kernel@vger.kernel.org
cc: acpi-devel@sourceforge.net, mingo@redhat.com
Subject: Re: [PATCH] SMP parsing rewrite, phase 1
Message-ID: <1504840000.1043123300@titus>
In-Reply-To: <Pine.LNX.4.44.0301201834310.26042-100000@dexter.groveronline.com>
References: <Pine.LNX.4.44.0301201834310.26042-100000@dexter.groveronline.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would be a lot easier to read if you could seperate out the
renames from the rest of the patch that actually does things.
It all makes me slightly nervous as this stuff is really easy
to break ... and it breaks wierd machines that are hard to test
for (been there, done that ;-)).

+static u8 raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };

Looks odd. May have merged forward badly, that got renamed in 2.5.59
to bios_cpu_apicid or something. 

Anyway, I'll give it a spin on my wierdo box, and see what happens.

M.

