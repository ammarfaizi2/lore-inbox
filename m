Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbTBCOeH>; Mon, 3 Feb 2003 09:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266431AbTBCOeH>; Mon, 3 Feb 2003 09:34:07 -0500
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:780 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP
	id <S266384AbTBCOeG> convert rfc822-to-8bit; Mon, 3 Feb 2003 09:34:06 -0500
Message-ID: <200302031545120119.2E88A90C@192.168.128.16>
In-Reply-To: <1044279732.20152.6.camel@irongate.swansea.linux.org.uk>
References: <200302021958160177.2A4B5622@192.168.128.16.suse.lists.linux.kernel>
 <p738ywyqk8w.fsf@oldwotan.suse.de>
 <1044279732.20152.6.camel@irongate.swansea.linux.org.uk>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Mon, 03 Feb 2003 15:45:12 +0100
From: "Carlos Velasco" <carlosev@newipnet.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Andi Kleen" <ak@suse.de>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20 Broken Path MTU Discovery?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2003 at 13:42 Alan Cox wrote:

>The real problem and the reason you have to stop at some point and say "no 
>way" is that third parties can send spoof icmps and force the connection
>down to stupid sizes otherwise. Forcing a BGP feed down to 68 bytes MTU
>tends to knock ISP's off the net for example.

Problem is that the parameter is not documented in filesystems/proc
Also, it is not so easy to send spoofed icmps as the icmp must contain the original packet with high len that caused the icmp.

Regards,
Carlos velasco




