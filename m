Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262043AbRENBm6>; Sun, 13 May 2001 21:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262048AbRENBms>; Sun, 13 May 2001 21:42:48 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:17412 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S262043AbRENBmj>;
	Sun, 13 May 2001 21:42:39 -0400
Date: Sun, 13 May 2001 18:42:37 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8
Message-ID: <20010513184237.A10604@lucon.org>
In-Reply-To: <20010511162412.A11896@lucon.org> <15100.30085.5209.499946@pizda.ninka.net> <20010511165339.A12289@lucon.org> <m13da9ky7s.fsf@frodo.biederman.org> <20010513110707.A11055@lucon.org> <m1y9s1jbml.fsf@frodo.biederman.org> <20010513181006.A10057@lucon.org> <m1sni8k9io.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1sni8k9io.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, May 13, 2001 at 07:24:31PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 07:24:31PM -0600, Eric W. Biederman wrote:
> 
> I agree it isn't intuitive, and if nfsroot=xxx is specified it should
> probably turn on if there is missing information.
> 
> But if you have to select the command line anyway....
> 
> Mostly I like the situation where I can compile it in and turn it on
> when I need it, instead of having to do thing differently if it is
> compiled in or not.
> 

In fact, I like the idea. But passing nfsroot=xxx to kernel doesn't
imply "ip=on" is very annoying. My setup worked fine with 2.4.4. It
took me a while to figure out why it didn't work with 2.4.4-ac8.

> > Have you tried
> > ramdisk on diskless alpha, arm, m68k, mips, ppc, sh, sparc, booting
> > over network?
> 
> First the booting situation on linux with respect to multiple platform
> sucks.  We pass parameters in weird ways on every platform.  The command
> line is the only thing that stays mostly the same.  I'm looking at what
> it takes to clean that up, so we can have multiplatform bootloaders.

I don't think we have total control over how to boot over network on
all platforms. On some platforms, you may only load kernel over the
network and run from it.

> 
> I have implemented what it takes to attach a ramdisk, and if you can
> boot an arbitrary kernel it isn't hard to have a program that attaches
> a ramdisk.  
> 
> Now although I believe this is the right direction to go, you will
> notice I ported the dhcp IP auto configuration from 2.2.19 to to 2.4.x
> Buying a little more time to get this working.

Thanks. I appreciate it.


H.J.
