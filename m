Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273383AbRIRLFw>; Tue, 18 Sep 2001 07:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273376AbRIRLFl>; Tue, 18 Sep 2001 07:05:41 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:11537
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S273372AbRIRLF0>; Tue, 18 Sep 2001 07:05:26 -0400
Date: Tue, 18 Sep 2001 07:09:12 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Bruce Blinn <blinn@MissionCriticalLinux.com>
Cc: root@chaos.analogic.com,
        Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
Message-ID: <20010918070912.A22047@animx.eu.org>
In-Reply-To: <Pine.LNX.3.95.1010917155338.17362A-100000@chaos.analogic.com> <3BA669A8.812D381D@MissionCriticalLinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3BA669A8.812D381D@MissionCriticalLinux.com>; from Bruce Blinn on Mon, Sep 17, 2001 at 02:22:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	# dd if=/dev/cdrom of=/tmp/cd1.iso
> 	dd: /dev/cdrom: Input/output error
> 	1440+0 records in
> 	1440+0 records out
>  
> 	# dd if=/dev/cdrom of=/tmp/cd2.iso bs=2k
> 	dd: /dev/cdrom: Input/output error
> 	360+0 records in
> 	360+0 records out
>  
> 	# cp /dev/cdrom /tmp/cd3.iso
> 	cp: /dev/cdrom: Input/output error
>  
> 	# ls -l /tmp/cd*
> 	-rw-------    1 root     root       737280 Sep 17 14:09 /tmp/cd1.iso
> 	-rw-------    1 root     root       737280 Sep 17 14:10 /tmp/cd2.iso
> 	-rw-------    1 root     root       737280 Sep 17 14:11 /tmp/cd3.iso

AFAIK, that's normal because when a cd is burned, the last 2 sectors are
always unreadable.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
