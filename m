Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270470AbTGNA2t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 20:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270472AbTGNA2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 20:28:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46056 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270470AbTGNA2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 20:28:48 -0400
Date: Mon, 14 Jul 2003 02:43:33 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: gcc-3.3.1-hammer vs current pre
Message-ID: <20030714004333.GG12104@fs.tum.de>
References: <20030713234024.GA2346@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713234024.GA2346@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 01:40:24AM +0200, J.A. Magallon wrote:

>...
> Is there any way to set compile flags for _subsystems_ ? To start
> a search on what breaks at -O2.
>...

It's only possible on a per-directory basis (excluding subdirectories).

Read section 7.6 in Documentation/kbuild/makefiles.txt .

drivers/acpi/Makefile in 2.4.22-pre contains an example (the ACPI code 
is compiled with -Os).

> TIA

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

