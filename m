Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129682AbQKQQDT>; Fri, 17 Nov 2000 11:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129697AbQKQQDJ>; Fri, 17 Nov 2000 11:03:09 -0500
Received: from [151.17.201.167] ([151.17.201.167]:40230 "EHLO proxy.teamfab.it")
	by vger.kernel.org with ESMTP id <S129682AbQKQQCy>;
	Fri, 17 Nov 2000 11:02:54 -0500
Message-ID: <3A154F7A.6F0F435D@teamfab.it>
Date: Fri, 17 Nov 2000 16:32:10 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
X-Mailer: Mozilla 4.72C-CCK-MCD Caldera Systems OpenLinux [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chip Schweiss <chip@innovates.com>
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre21 - IP kernel level autoconfiguration
In-Reply-To: <H00000650001a074.0974474275.dublin.innovates.com@MHS>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Schweiss wrote:
> 
> The problem seems to be deeper than that.  I first encountered the
> problem with only bootp compiled in.  In my configuration I am not able
> to supply kernel parameters on the client which may be why you were
> able to get bootp to execute.

Seem that you have to specify the "ip=bootp" options now

*     <PROTO>:
*        off|none         - don't do autoconfig at all (DEFAULT)
*        on|any           - use any configured protocol
*        dhcp|bootp|rarp  - use only the specified protocol
*        both             - use both BOOTP and RARP (not DHCP)

Anyway I'll do more investigation about my problem to get bootp
work with dhcp compiled into kernel next week

luca
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
