Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291406AbSBSNgq>; Tue, 19 Feb 2002 08:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291414AbSBSNgg>; Tue, 19 Feb 2002 08:36:36 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:9482 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S291406AbSBSNgS>; Tue, 19 Feb 2002 08:36:18 -0500
Date: Tue, 19 Feb 2002 14:36:10 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Sebastian Manzano <sebastian.manzano@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Sony P-I/O device?
Message-ID: <20020219133610.GG612@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <3C724055.1811D3D6@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C724055.1811D3D6@sun.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 09:08:53AM -0300, Sebastian Manzano wrote:

> Hi,
>   I have tried sonypi module in my Sony PCG-FXA36 and it seems to be looking for
> a 0x7113 device that I don't have (lspci):

Not exactly. It does check for 'is_sony_vaio_laptop' variable.
The check for the pci device is just an additionnal clue on the kind
of sonypi device you have.

Does your kernel print a line:
	Sony Vaio laptop detected.
on boot ? I suppose not, and that would explain the sonypi init failure.

Could you send me the output of dmidecode ?
	http://ftp.linux.org.uk/pub/linux/alan/DMI/dmidecode.c
	
Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
