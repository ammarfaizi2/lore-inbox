Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTFKVBa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTFKVBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:01:30 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44025 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264464AbTFKVB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:01:29 -0400
Date: Wed, 11 Jun 2003 23:15:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Eric Valette <eric.valette@free.fr>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
Message-ID: <20030611211506.GD16164@fs.tum.de>
References: <3EE66C86.8090708@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE66C86.8090708@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 01:40:54AM +0200, Eric Valette wrote:
>...
> I would personnally suggest that you classify the things using the 
> following filter :
> 	a) Server (SMP, SCSI, RAID, journaling filesystems, ...),
> 	b) laptop (ACPI, CPUFREQ, Software suspend, IDE power save,...),
> 	c) desktop (File system efficiency, new hardware support,...),
> 	d) all systems
>...

Why are journaling filesystems only for servers?
Is file system efficiency not relevant on servers?

The important sections are more likely (ordered by priority):
- bug fixes (e.g. aic7xxx)
- support for additional hardware (e.g. ACPI update)
- new features (e.g. XFS)

These groups are not mutual exclusive, e.g. the ACPI update also 
includes new features.

The important thing is that this is inside a stable kernel series and an 
update that makes things better for 100 people but makes things worse 
for one person is IMHO bad since it's a regression for one person.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

