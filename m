Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbUKKGNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbUKKGNx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 01:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUKKGNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 01:13:53 -0500
Received: from ns.focomunicatii.ro ([212.146.75.6]:65214 "HELO
	focomunicatii.ro") by vger.kernel.org with SMTP id S262093AbUKKGNv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 01:13:51 -0500
Message-ID: <20041111061210.26312.qmail@focomunicatii.ro>
References: <20041107214427.20301.qmail@focomunicatii.ro>
            <20041107224803.GA29248@electric-eye.fr.zoreil.com>
            <20041109000006.GA14911@electric-eye.fr.zoreil.com>
            <20041109232510.GA5582@electric-eye.fr.zoreil.com>
            <20041110201010.18341.qmail@focomunicatii.ro>
            <20041110212835.GA23758@electric-eye.fr.zoreil.com>
In-Reply-To: <20041110212835.GA23758@electric-eye.fr.zoreil.com>
From: sebastian.ionita@focomunicatii.ro
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: seby@focomunicatii.ro, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       alan@redhat.com, jgarzik@pobox.com
Subject: Re: ZyXEL GN650-T
Date: Thu, 11 Nov 2004 08:12:10 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu writes: 

> sebastian.ionita@focomunicatii.ro <sebastian.ionita@focomunicatii.ro> :
> [...]
>> The kernel compiles but I have 1 unresolved simbole in the via-velocity 
>> modul
>> depmod: *** Unresolved symbols in 
>> /lib/modules/2.4.28-rc2/kernel/drivers/net/via-velocity.o
>> depmod:         crc_ccitt_R3771b461 
> 
> Can you grep for crc_ccitt the output of 'nm lib/lib.a' in your build
> tree and check that CONFIG_CRC_CCITT is enabled in your .config ? 
> 
> crc_ccitt is EXPORT_SYMBOLed by lib/crc-ccitt.c and should be linked in
> your new kernel.
Yes is enabled in my .config and it exists,
crc-ccitt.o:
00000000 T crc_ccitt
00000000 R crc_ccitt_table
0000001a R __kstrtab_crc_ccitt
00000000 R __kstrtab_crc_ccitt_table
00000008 R __ksymtab_crc_ccitt
00000000 R __ksymtab_crc_ccitt_table
but why then depmod say's that it isn't there? 

> 
> --
> Ueimor
 


____________________________________________________________
SC. FO Comunicatii SRL.
Sebastian Ionita
Administrator Sistem
mobil: 0724 212408
tel fix: 0264 450456 


