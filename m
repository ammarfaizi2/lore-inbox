Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbTKHHqg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 02:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbTKHHqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 02:46:36 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:13458
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261645AbTKHHqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 02:46:35 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
Subject: Re: 2.6: value 0x37ffffff truncated to 0x37ffffff
Date: Sat, 8 Nov 2003 01:42:44 -0600
User-Agent: KMail/1.5
References: <Pine.LNX.4.51.0311071628470.5963@dns.toxicfilms.tv>
In-Reply-To: <Pine.LNX.4.51.0311071628470.5963@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311080142.45003.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 November 2003 09:36, Maciej Soltysiak wrote:
> Hi,
>
> during make bzImage on 2.6 I notoriously get this warning:
>
> [exerpt]
>   LD      vmlinux
>   AS      arch/i386/boot/setup.o
> arch/i386/boot/setup.S: Assembler messages:
> arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to
> 0x37ffffff LD      arch/i386/boot/setup
>   OBJCOPY arch/i386/boot/compressed/vmlinux.bin
> [eo exerpt]
>
> I have been browsing through the archives and I got the feeling
> that this has been already been approached. But I am getting this
> since I ever tried 2.5 (about 2.5.53). By 2.6.0-test9-bk11 it is
> still there. I have been compiling on 2 different machines. I have
> their specs.
>
> Is there anything I could supply to try to resolve this?

What version of the tools you're using to compile it, maybe?  (Distro, gcc 
version, binutils version, etc...  And if it's a non-intel system or 
cross-compiling or something, that might be good to mention too...)

Rob
