Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318767AbSHBJk2>; Fri, 2 Aug 2002 05:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318770AbSHBJk2>; Fri, 2 Aug 2002 05:40:28 -0400
Received: from [195.63.194.11] ([195.63.194.11]:31237 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318767AbSHBJk0>; Fri, 2 Aug 2002 05:40:26 -0400
Message-ID: <3D4A5320.8070100@evision.ag>
Date: Fri, 02 Aug 2002 11:38:40 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: "Michel Eyckmans (MCE)" <mce@pi.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.30 unresolved symbol: elv_queue_empty
References: <200208012327.g71NRWZp013762@jebril.pi.be>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Michel Eyckmans (MCE) napisa³:
> The subject says nearly all: with 2.5.30, I get the following:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.5.30/kernel/drivers/block/floppy.o
> depmod:         elv_queue_empty
> depmod: *** Unresolved symbols in /lib/modules/2.5.30/kernel/drivers/ide/atapi.o
> depmod:         elv_queue_empty
> depmod: *** Unresolved symbols in /lib/modules/2.5.30/kernel/drivers/ide/ide-mod.o
> depmod:         elv_queue_empty
> 
> Oh, while I'm at it: ever since the IDE cleanup started, loading one
> or more of the IDE/CD related modules for a second time after they 
> have been unloaded once already results in a pretty bad oops (total
> lockup). Took me quite a while to narrow this down. 2.5.29 still has 
> this problem. I was going to submit the oops for 2.5.30 if applicable, 
> but first gotta get that symbol resolved...
> 
> This is on a measly SMP P5 with limited memory which is all-SCSI 
> except for the CD drive. Hence the modules.

Yes having the oops at hand would be rather helpfull.
Unfortunately I don't have a SCSI system at hand, which makes
it a bit inconvenient too me to test ide.c compiled as module.

