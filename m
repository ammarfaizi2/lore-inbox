Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266867AbRGQRVR>; Tue, 17 Jul 2001 13:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266831AbRGQRU6>; Tue, 17 Jul 2001 13:20:58 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:37388 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S266830AbRGQRUs>;
	Tue, 17 Jul 2001 13:20:48 -0400
Date: Tue, 17 Jul 2001 10:20:50 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Shane Nay <shane@minirl.com>, Pavel Machek <pavel@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: Re: Toolchains
Message-ID: <20010717102050.A21784@lucon.org>
In-Reply-To: <20010717083514.A19836@lucon.org> <Pine.LNX.4.10.10107170940420.16793-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10107170940420.16793-100000@transvirtual.com>; from jsimmons@transvirtual.com on Tue, Jul 17, 2001 at 09:41:14AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2001 at 09:41:14AM -0700, James Simmons wrote:
> 
> > The toolchain in my RedHat 7.1 mips port is as good as the x86 version
> > for RedHat 7.1. Since there is no mips maintainer for gcc, many
> > mips patches aren't reviewed. But they are in my mips toolchain.
> 
> Where are they? On the oss.sgi.com site.

My mini-port of RedHat 7.1 is at

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/

you should be able to put a small RedHat 7.1 on the mips/mipsel box and
compile the rest of RedHat 7.1 yourselves.

Here are something you should know:

1. The cross compiler hosted on RedHat 7.1/ia32 is provided as a
toolchain rpm. The binary rpms for the mips and mipsel cross compilers
are included. You will need glibc 2.2.3-11 or above to use those
rpms. The glibc x86 binary rpms under RPMS/i386 should be ok.
2. You have to find a way to put those rpms on your machine. I use
network boot and NFS root to do it.
3. install.tar.bz2 has some scripts to prepare NFS root and install
RedHat 7.1 on a hard drive.

Thanks.


H.J.
