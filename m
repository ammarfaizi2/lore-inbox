Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266606AbRHJJbI>; Fri, 10 Aug 2001 05:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266706AbRHJJa6>; Fri, 10 Aug 2001 05:30:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60777 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S266688AbRHJJaq>; Fri, 10 Aug 2001 05:30:46 -0400
To: Mike Jadon <mikej@umem.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI NVRAM Memory Card
In-Reply-To: <5.1.0.14.0.20010622101907.03ac21b0@192.168.0.5>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Aug 2001 03:24:10 -0600
In-Reply-To: <5.1.0.14.0.20010622101907.03ac21b0@192.168.0.5>
Message-ID: <m17kwctghx.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Jadon <mikej@umem.com> writes:

> My company has released a PCI NVRAM memory card but we haven't developed a Linux
> 
> driver for it yet.  We want the driver to be open to developers to build upon.
> Is there a specific path we should follow with this being our goal?  

You might want to check out the development of the mtd subsystem.
http://www.linux-mtd.infradead.org/

This is probably what you want to write a driver for for your NVRAM PCI card.

Eric
