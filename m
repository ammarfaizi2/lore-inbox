Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262035AbRENBKc>; Sun, 13 May 2001 21:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262043AbRENBKW>; Sun, 13 May 2001 21:10:22 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:16388 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S262035AbRENBKI>;
	Sun, 13 May 2001 21:10:08 -0400
Date: Sun, 13 May 2001 18:10:06 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8
Message-ID: <20010513181006.A10057@lucon.org>
In-Reply-To: <20010511162412.A11896@lucon.org> <15100.30085.5209.499946@pizda.ninka.net> <20010511165339.A12289@lucon.org> <m13da9ky7s.fsf@frodo.biederman.org> <20010513110707.A11055@lucon.org> <m1y9s1jbml.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1y9s1jbml.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, May 13, 2001 at 01:24:18PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 01:24:18PM -0600, Eric W. Biederman wrote:
> "H . J . Lu" <hjl@lucon.org> writes:
> 
> > It doesn't make any senses. When I specify CONFIG_IP_PNP and
> > BOOTP/DHCP, I want a kernel with IP config using BOOTP/DHCP. I would
> > expect IP config is turned for BOOTP/DHCP by default. You can turn
> > it off by passing "ip=off" to kernel. Did I miss something?
> 
> Since you have to set the command line anyway ip=dhcp is no extra
> burden and it lets you use the same kernel to boot of the harddrive etc.

Why do I have to set "ip=dhcp"? If I have selected CONFIG_IP_PNP and
DHCP in my kernel configuration, should it be on by default?

> 
> > > This same situation exists for 2.2.18 & 2.2.19 as well.
> > > 
> > > The only way to get long term stability out of this is to write
> > > a user space client, you can put in a ramdisk.  One of these days...
> > 
> > It doesn't work with diskless machines which don't support ramdisk
> > during boot.
> 
> I don't believe that is a real world situation.
> 
> I boot diskless all of time and supporting a ramdisk is trivial.  You
> just a have a program that slaps a kernel a ramdisk, and some command
> line arguments into a single image, along with a touch of adapter code
> to set the kernel parameters correctly and then boot that.

Let me guess. Your diskless machines are mostly x86. Have you tried
ramdisk on diskless alpha, arm, m68k, mips, ppc, sh, sparc, booting
over network?


H.J.
