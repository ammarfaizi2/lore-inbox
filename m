Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSGVGz4>; Mon, 22 Jul 2002 02:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSGVGz4>; Mon, 22 Jul 2002 02:55:56 -0400
Received: from monster.nni.com ([216.107.0.51]:9233 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S316532AbSGVGzz>;
	Mon, 22 Jul 2002 02:55:55 -0400
Date: Tue, 23 Jul 2002 02:56:39 -0400
From: Andrew Rodland <arodland@noln.com>
To: Yann Dirson <ydirson@altern.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, kaos@ocs.com.au
Subject: Dual BSD/GPL [ was: Re: Generic modules documentation is outdated]
Message-Id: <20020723025639.1baf8c1b.arodland@noln.com>
In-Reply-To: <20020718232535.GB8165@bylbo.nowhere.earth>
References: <20020704212240.GB659@bylbo.nowhere.earth>
	<20020718210259.GJ19580@bylbo.nowhere.earth>
	<1027032521.8154.48.camel@irongate.swansea.linux.org.uk>
	<20020718232535.GB8165@bylbo.nowhere.earth>
X-Mailer: Sylpheed version 0.7.8claws55 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002 01:25:35 +0200
Yann Dirson <ydirson@altern.org> wrote:

> On Thu, Jul 18, 2002 at 11:48:41PM +0100, Alan Cox wrote:
> > On Thu, 2002-07-18 at 22:02, Yann Dirson wrote:
> > > - I have installed no proprietary driver, all loaded drivers
> > > declare to be"GPL" or "Dual BSD/GPL". 
> > 
> > Something you loaded was missing a MODULE_LICENSE tag - modern
> > insmod will warn on this one
> 
> I wrote:
> > I found a good candidate in the Apple HFS module
> 
> Hm, no, I found the real one (although HFS has the problem):
> 
> # modprobe ppp_deflate
> Warning: loading
> /lib/modules/2.4.18+preempt/kernel/drivers/net/ppp_deflate.o will
> taint the kernel: non-GPL license - BSD without advertisement clause
> 
> I'm pretty sure the "BSD without advertisement clause" license should
> not taint the kernel, should it ?
> 


	* According to Alan Cox, a license of "BSD without advertisement
	clause" is not a suitable free software license. This license type
	allows binary only modules without source code. Any modules in the
	kernel tarball with this license should really be "Dual BSD/GPL".

It would seem, and another poster confirms, that this change has
already been made in 2.4.19-pre*



