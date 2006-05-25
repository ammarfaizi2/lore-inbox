Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWEYLJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWEYLJI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 07:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbWEYLJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 07:09:08 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:45262 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S964816AbWEYLJH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 07:09:07 -0400
Subject: Re: Program to convert core file to executable.
From: Marcel Holtmann <marcel@holtmann.org>
To: vamsi krishna <vamsi.krishnak@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3faf05680605241018q302d5c0em6844765f81669498@mail.gmail.com>
References: <3faf05680605241018q302d5c0em6844765f81669498@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 13:04:09 +0200
Message-Id: <1148555049.4734.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vamsi,

> o I have written the following program to convert a core file to a
> executable, and tried to execute the converted executable but my
> system __HANGED__, The kernel did'nt give any messages the complete
> system was stuck.
> 
> o Theoretically , the OS loader should jump into the virtual address
> specified at 'ELF_HDR.e_entry and start executing instructions from
> that point if the ELF_TYPE is ET_EXEC.
> 
> o So I wrote a program which
> changes ELF_TYPE form ET_CORE to ET_EXEC and modifies e_entry to
> virtual address of the 'main' symbol, since the core file has valid offset
> to access the PHDRS, and for ET_EXEC the elf loader just need to map
> the PHDRS at the vaddr specified and start jump to e_entry.
> 
> o Is there anything I'am missing, can some experts throw light on why
> kerOn Wed, 2006-05-24 at 22:48 +0530, vamsi krishna wrote:
> Hello All,
> nel does not load this program, could it be a bug in the kernel code ?

which kernel version do you use? What kind of Linux distribution do you
use? What hardware architecture do you use?

Regards

Marcel


