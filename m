Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269963AbRHJSLQ>; Fri, 10 Aug 2001 14:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269964AbRHJSLG>; Fri, 10 Aug 2001 14:11:06 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:30857
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S269963AbRHJSK4>; Fri, 10 Aug 2001 14:10:56 -0400
Date: Fri, 10 Aug 2001 11:10:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Christian Borntraeger <CBORNTRA@de.ibm.com>, ext3-users@redhat.com,
        linux-kernel@vger.kernel.org, Carsten Otte <COTTE@de.ibm.com>
Subject: Re: BUG: Assertion failure with ext3-0.95 for 2.4.7
Message-ID: <20010810111044.G31136@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <OF5E574EE5.AF3B6F6F-ONC1256AA2.0026D8D3@de.ibm.com> <3B72DD66.A6F65247@zip.com.au>, <3B72DD66.A6F65247@zip.com.au> <20010810104450.F31136@cpe-24-221-152-185.az.sprintbbd.net> <3B74235F.8F6943D9@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B74235F.8F6943D9@zip.com.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2001 at 11:09:35AM -0700, Andrew Morton wrote:
> Tom Rini wrote:
> > 
> > With this patch my first oops seems to have gone away.  I'm repeating
> > the test again, but dbench'ing 2,4,8,16,32 and then 64 (until disk
> > space ran out) worked this time.
> 
> Thanks, Tom and Christian.
> 
> Yup, it's definitely a bug and the fix will be in 0.9.6 (in fact the way
> things are looking at present it'll be the only substantive change in
> 0.9.6).
> 
> If it's possible, could you please also test journalled data mode?

Sure.  It'll take me a bit longer for that tho (I've gotta get my
spare ppc box happily booting 2.4 off the disk first..)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
