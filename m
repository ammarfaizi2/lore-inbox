Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTIMLqQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 07:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbTIMLqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 07:46:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35800 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262131AbTIMLqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 07:46:15 -0400
Date: Sat, 13 Sep 2003 13:46:10 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Scott Thomason <scott@thomasons.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Forcing CONFIG_X86_IO_APIC=n
Message-ID: <20030913114610.GD27368@fs.tum.de>
References: <20030907090610.4a47ec2a.scott@thomasons.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030907090610.4a47ec2a.scott@thomasons.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 09:06:10AM -0500, Scott Thomason wrote:
> I'd like to try forcing CONFIG_X86_IO_APIC=n while I test 2.6.0-test4,
> but apparently some part of the kernel build re-runs my .config thru
> something and keeps changing it back to 'y'. Is there any way to
> accomplish this?

You have to do the following:
- disable SMP support
- say "n" to "IO-APIC support on uniprocessors"

> ---scott

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

