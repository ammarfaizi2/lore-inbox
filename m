Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSHJGRV>; Sat, 10 Aug 2002 02:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316608AbSHJGRV>; Sat, 10 Aug 2002 02:17:21 -0400
Received: from codepoet.org ([166.70.99.138]:61649 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S316601AbSHJGRU>;
	Sat, 10 Aug 2002 02:17:20 -0400
Date: Sat, 10 Aug 2002 00:21:08 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: davidm@hpl.hp.com, Arnd Bergmann <arnd@bergmann-dalldorf.de>,
       linux-kernel@vger.kernel.org
Subject: Re: klibc development release
Message-ID: <20020810062107.GC2551@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"H. Peter Anvin" <hpa@zytor.com>, davidm@hpl.hp.com,
	Arnd Bergmann <arnd@bergmann-dalldorf.de>,
	linux-kernel@vger.kernel.org
References: <aivdi8$r2i$1@cesium.transmeta.com> <200208090934.g799YVZe116824@d12relay01.de.ibm.com> <200208091754.g79HsJkN058572@d06relay02.portsmouth.uk.ibm.com> <3D541018.4050004@zytor.com> <15700.4689.876752.886309@napali.hpl.hp.com> <3D541478.40808@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D541478.40808@zytor.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 09, 2002 at 12:14:00PM -0700, H. Peter Anvin wrote:
> David Mosberger wrote:
> >>>>>>On Fri, 09 Aug 2002 11:55:20 -0700, "H. Peter Anvin" <hpa@zytor.com> 
> >>>>>>said:
> >>>>>
> >
> >  HPA> Hmf... some of these seem to be outright omissions
> >  HPA> (pivot_root() and umount2() especially), and probably indicate
> >  HPA> bugs or that the stock kernel isn't up to date anymore.
> >
> >  HPA> I can see umount() being missing (as in "use umount2()").
> >
> >Alpha calls umount2() "oldumount"; ia64 never had a one-argument
> >version of umount(), so there is no point creating legacy (and the
> >naming is inconsistent anyhow...).
> >
> 
> The gratuitous inconsistencies between platforms is something that is 
> currently driving me up the wall.  I'm starting to think the NetBSD 
> people have the right idea: when you add a system call on NetBSD, you 
> only have to add it in one place and it becomes available on all the 
> platforms they support.  Of course, you can provide a custom 
> implementation for any one platform, but the idea is to keep as much of 
> the code generic as possible...

Amen brother.   That would be great!  But I'm not holding 
my breath waiting to see it,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
