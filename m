Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314838AbSEUPrd>; Tue, 21 May 2002 11:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314841AbSEUPrc>; Tue, 21 May 2002 11:47:32 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11136 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314838AbSEUPrc> convert rfc822-to-8bit; Tue, 21 May 2002 11:47:32 -0400
Date: Tue, 21 May 2002 11:44:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: AW: DCOM coming?
In-Reply-To: <D3524C0FFDC6A54F9D7B6BBEECD341D5D56F59@HBMNTX0.da.hbm.com>
Message-ID: <Pine.LNX.3.95.1020521112732.1232A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2002, Wessler, Siegfried wrote:

> Hello,
> 
> > -----Ursprüngliche Nachricht-----
> > Von: Mark Hahn [mailto:hahn@physics.mcmaster.ca]
> 
> > 
> > why would the kernel be involved?  seems perfectly userland to me.
> > 
> 
> What about TCP/IP or USB? Okay USB is not only a protocol, but a lot of
> hardware. But DCOM into the kernel would mean that a lot of people would
> take care about it. The sourceforge project freedce looks nice, but to me
> "as user" it's a bit tiny. 
> 
> If DCOM were wraped into the kernel, everyone could use it, as it would be a
> part of the os itself. That makes it more interesting for companies who make
> installations using DCOM to use Linux (also). And it would help us
> firmware/hardware oriented programmers to use Embedded Linux in
> infrastructures that are Microsoft dominated, because of MS propietaire
> protocols like DCOM.

The "Distributed Component Object Model" is a Microsoft extension of
"COM" which is in its death throes. It is just another proprietary
programming interface.

Linux/Unix has its own non-proprietary API. You can write user-mode
interface libraries to throw whatever layers onto that basic API
that you want. Of course it's a waste of programmer time and run-time
CPU cycles as well.

The "Distributed" part of COM, in theory, allows you to use the
RS-232C port on a M$ computer, over the network, on your M$
computer. If this is what you want, you can write Client/Server
stuff on both sides and stay away from license issues with embedded
systems.

COM and DCOM have no place in the kernel, if fact, they have
no place in Windows kernels either. They should not have been
molded into M$ kernels and they are not in Win-2000/Professional
or Win-NT.

On these machines, a separate task handles COM. If they are now putting
it into the kernel on other versions, it's broken by design.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

