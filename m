Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUI1Ba6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUI1Ba6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 21:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUI1Ba6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 21:30:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38378 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265029AbUI1Bay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 21:30:54 -0400
Date: Tue, 28 Sep 2004 02:30:52 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: rene@rocklinux-consulting.de
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: sym53c8xx_2 regressions in 2.6.9-rc2
Message-ID: <20040928013052.GS16153@parcelfarce.linux.theplanet.co.uk>
References: <1096316016.1714.77.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1096316016.1714.77.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 04:13:26PM -0400, James Bottomley wrote:
> Do you have any ideas about this...it doesn't seem to be connected with
> domain vaildation.  The errors apparently show up during operation.

Thanks for forwarding this, James.  Rene, it would be useful for you
to submit bug reports to the maintainer directly, or even contact linux-scsi.
I don't have time to wade through the mountains of crap on linux-kernel.

> From: René Rebe <rene@rocklinux-consulting.de>
> 
> James, your recent 2.6.9-pre changes seem to cause new regressions in 
> the sym53c8xx_2 driver.
> 
> On my U30 sparc64 box I get many errors in the system log:
> 
> Sep 20 15:28:34 sundown kernel: sym0:0:0:phase change 6-7 11@c7ff7b90 
> resid=6.
> Sep 20 15:28:34 sundown last message repeated 2 times
> 
> those did not show up in any other 2.6 kernel up to .8.1 ...

When do these show up?  Are they at initialisation time or are they during
normal operation?  You report the dmesg from a 2.6.8 kernel, how does the
2.6.9-rc2 one differ?  Is the sym2 driver version 2.1.18j in both kernels?


-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
