Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbTEVGyT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 02:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbTEVGyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 02:54:19 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:26886 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262520AbTEVGyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 02:54:18 -0400
Message-ID: <3ECC770B.4030200@yahoo.com>
Date: Thu, 22 May 2003 00:06:51 -0700
From: Lars <lhofhansl@yahoo.com>
Organization: What? Organized??
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: HD DMA disabled in 2.4.21-rc2, works fine in 2.4.20
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please read the entire thread.

I am the person who started the thread and yes, I have
# CONFIG_BLK_DEV_VIA82CXXX is not set

Then again, I also do not have a VIA chipset, Jeffrey had
the same problem and he has the VIA chipset, that's where
the confusion comes from.

 From the same post:
00:1e.0 PCI bridge: Intel Corporation 82801BA PCI (rev 03)
00:1f.0 ISA bridge: Intel Corporation 82801BAM ISA Bridge (ICH2) (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801BAM IDE U100 (rev 03)

It seems to me that I'm missing something very obvious.

Anyway, as there seems to be no solution at hand for me, so I'm back
to 2.4.20 for the time being until I have time have a look at the
source myself.

-- Lars


-----------------------------------------------------------------


The person who posted their DMESG had it unset.

Here's an archive of the post:

http://www.ussg.iu.edu/hypermail/linux/kernel/0305.2/0440.html

And the line:

# CONFIG_BLK_DEV_VIA82CXXX is not set

From: Lars (lhofhansl@yahoo.com)
Date: Sun May 18 2003 - 22:03:16 EST

--eric

-----Original Message-----
From: Jeffrey W. Baker [mailto:jwbaker@acm.org]
Sent: Monday, May 19, 2003 5:01 PM
To: Tomas Szepe; linux-kernel@vger.kernel.org
Subject: Re: HD DMA disabled in 2.4.21-rc2, works fine in 2.4.20

On Mon, 2003-05-19 at 15:29, Tomas Szepe wrote:
 > > [alan@lxorguk.ukuu.org.uk]
 > >
 > > On Llu, 2003-05-19 at 21:04, Jeffrey W. Baker wrote:
 > > > I was using Via IDE chipset and, yes, I had configured the kernel for
 > > > VIA support. That's why it worked in 2.4.20. But it stopped working
in
 > > > 2.4.21-rc.
 > >
 > > VIA IDE should be working reliably, my main test box is an EPIA series
 > > VIA system so the VIA IDE does get a fair beating
 >
 > This person is running with CONFIG_BLK_DEV_VIA82CXXX unset.

No, this person is not.

-jwb


