Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132051AbQLNFjJ>; Thu, 14 Dec 2000 00:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132490AbQLNFi6>; Thu, 14 Dec 2000 00:38:58 -0500
Received: from cm698210-a.denton1.tx.home.com ([24.17.129.59]:43524 "HELO
	cm698210-a.denton1.tx.home.com") by vger.kernel.org with SMTP
	id <S132051AbQLNFit>; Thu, 14 Dec 2000 00:38:49 -0500
Message-ID: <3A3855C4.B997ACFC@home.com>
Date: Wed, 13 Dec 2000 23:08:20 -0600
From: Matthew Vanecek <linux4us@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12 randomly hangs up
In-Reply-To: <Pine.LNX.4.21.0012132205250.5935-100000@winds.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Byron Stanoszek wrote:
> 
> On Wed, 13 Dec 2000, Lukasz Trabinski wrote:
> 
> > In article <20001213121349.A6787@sarah.kolej.mff.cuni.cz> you wrote:
> >
> > > I can (re)confirm that. I work several hours on console without any
> > > problem ... then I start X session and after several minutes system
> > > hangs.
> >
> > I can confirm that, too.
> > Todaye, crashed two difference machines
> > One: AMD-K6 3D, 300 MHz, RH 7.0 + updates, 64MB RAM
> > Second one: AMD Athlon 600, 600MHz with, 128MB RAM, RH 7.0+updates
> >
> > > Red Hat 7.0, XFree-3.3.6 (SVGA server), S3Virge/G2 (4MB)
> 
> I've been running 2.4.0-test12 patched with only the O_SYNC bug fix and I have
> _not_ experienced any lockups on this machine.
> 
> Classic Athlon 825(750) MHz, 128MB Ram,
> RH 7.0 based w/glibc 2.2, XFree-3.3.6 (S3 Trio 64 accel server), gcc 2.95.2
> 
> Not sure what the problem is yet... keep trying folks. :)
> 

Maybe it's the 3.3.6.  RH 7.0 comes with 4.0.1, and a newer glibc. 
Perhaps try recompiling XFree86 against the latest RH 7.0 glibc (2.1.94)
and see what happens, or upgrade your XFree86 to the standard RH 7.0
XFree86 4.0.1.

-- 
Matthew Vanecek
perl -e 'print
$i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'
********************************************************************************
For 93 million miles, there is nothing between the sun and my shadow
except me.
I'm always getting in the way of something...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
