Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266690AbSLDP3f>; Wed, 4 Dec 2002 10:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266693AbSLDP3e>; Wed, 4 Dec 2002 10:29:34 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:24575 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266690AbSLDP3e>; Wed, 4 Dec 2002 10:29:34 -0500
Date: Wed, 4 Dec 2002 10:37:01 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Alex Riesen <Alexander.Riesen@synopsys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: world read permissions on /proc/irq/prof_cpu_mask and ...smp_affinity
In-Reply-To: <20021203114938.GD26745@riesen-pc.gr05.synopsys.com>
Message-ID: <Pine.LNX.4.44.0212041036001.22730-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Dec 2002, Alex Riesen wrote:

> Is there any reason to set the permissions to 0600?
> It makes the admin to login as root just to look on the
> current system state.
> Is there something against 0644?

i've got nothing against 0644, 0600 was just the default paranoid value.  
(reading it could in theory mean an IO-APIC read.)

	Ingo

