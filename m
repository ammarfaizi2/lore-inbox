Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUI1MJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUI1MJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 08:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267660AbUI1MJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 08:09:27 -0400
Received: from mx01.qsc.de ([213.148.129.14]:5320 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S267656AbUI1MJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 08:09:21 -0400
Message-ID: <41595406.2080500@rocklinux-consulting.de>
Date: Tue, 28 Sep 2004 14:07:34 +0200
From: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@rocklinux-consulting.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, valentin@rocklinux-consulting.de
Subject: Re: sym53c8xx_2 regressions in 2.6.9-rc2
References: <1096316016.1714.77.camel@mulgrave> <20040928013052.GS16153@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040928013052.GS16153@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, Matthew Wilcox wrote: > On Mon, Sep 27, 2004 at
	04:13:26PM -0400, James Bottomley wrote: > >>Do you have any ideas
	about this...it doesn't seem to be connected with >>domain vaildation.
	The errors apparently show up during operation. > > > Thanks for
	forwarding this, James. Rene, it would be useful for you > to submit
	bug reports to the maintainer directly, or even contact linux-scsi. > I
	don't have time to wade through the mountains of crap on linux-kernel.
	[...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Matthew Wilcox wrote:
> On Mon, Sep 27, 2004 at 04:13:26PM -0400, James Bottomley wrote:
> 
>>Do you have any ideas about this...it doesn't seem to be connected with
>>domain vaildation.  The errors apparently show up during operation.
> 
> 
> Thanks for forwarding this, James.  Rene, it would be useful for you
> to submit bug reports to the maintainer directly, or even contact linux-scsi.
> I don't have time to wade through the mountains of crap on linux-kernel.

And I'm not on any linux-* list, sorry. The next time I will write to 
linux-scsi directly.

>>On my U30 sparc64 box I get many errors in the system log:
>>
>>Sep 20 15:28:34 sundown kernel: sym0:0:0:phase change 6-7 11@c7ff7b90 
>>resid=6.
>>Sep 20 15:28:34 sundown last message repeated 2 times
>>
>>those did not show up in any other 2.6 kernel up to .8.1 ...
> 
> 
> When do these show up?  Are they at initialisation time or are they during
> normal operation?  You report the dmesg from a 2.6.8 kernel, how does the
> 2.6.9-rc2 one differ?  Is the sym2 driver version 2.1.18j in both kernels?

Both, at initialization time _and_ normal operation.

The 2.6.9-rc2 dmesg does list the same devices - but with 
"sym0:0:0:phase change 6-7 ..." between the devices beeing detected.

I'll rebuild the kernel with the defective scsi driver (I reverted the 
changes to get a functional system ...) when I'm back in the office in 
some hours. The 2.6.9-rc2 does contain the domain validation changes, I 
will take a look if the patch in 2.6.9-rc2 does change the version 
string if this matters.

Have fun,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
             +49 (0)30  255 897 45
