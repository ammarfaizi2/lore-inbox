Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbTAUPdR>; Tue, 21 Jan 2003 10:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266078AbTAUPdR>; Tue, 21 Jan 2003 10:33:17 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:2696 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265077AbTAUPdQ>;
	Tue, 21 Jan 2003 10:33:16 -0500
Date: Tue, 21 Jan 2003 16:41:57 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "HAMILTON,DAVID (HP-Ireland,ex2)" <david_hamilton3@hp.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux Kernel SCSI Blacklist
Message-ID: <20030121164157.A17848@ucw.cz>
References: <253B1BDA4E68D411AC3700D0B77FC5F809632CAF@patsydan.dublin.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <253B1BDA4E68D411AC3700D0B77FC5F809632CAF@patsydan.dublin.hp.com>; from david_hamilton3@hp.com on Tue, Jan 21, 2003 at 02:57:24PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 02:57:24PM -0000, HAMILTON,DAVID (HP-Ireland,ex2) wrote:
> I understand that this is not necessarily a bug, but I need to quickly
> determine why the HP VA7410 disk array is listed in the scsi_scan.c file,
> and the implications and/or correctness of the flags attached to it.

The blacklist table in the scsi_scan.c file says the device has sparse
(non-consecutive) LUN numbers and that the probing must not stop at
first non-existing LUN, but instead all possible LUNs need to be probed.

This is most likely true.

> Apologies if this is not the correct place to ask, but I need help urgently
> on this one.
> 
> Thanks,
> 	David.
> 
> David Hamilton
> Senior Technical Consultant
> HP Ireland 
> 
> Direct Line 
> Fax Number 
> Mobile Phone 
> Email 
> +353 (1) 6158320
> +353 (1) 6158296
> +353 (86) 8158320
> David.Hamilton3@hp.com 
> This message is confidential and may also be legally privileged. If you are
> not the intended recipient please notify the sender immediately. You must
> not copy this message or use it for any purpose, nor publish or disclose its
> contents to any other person. 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
