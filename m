Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSHMK20>; Tue, 13 Aug 2002 06:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSHMK20>; Tue, 13 Aug 2002 06:28:26 -0400
Received: from rj.sgi.com ([192.82.208.96]:49315 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S314529AbSHMK2Z>;
	Tue, 13 Aug 2002 06:28:25 -0400
Message-ID: <3D58E053.7FE5630E@alphalink.com.au>
Date: Tue, 13 Aug 2002 20:32:51 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org.com>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208131111460.8911-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> On Tue, 13 Aug 2002, Greg Banks wrote:
> 
> > The problem is deciding what the original rules were supposed to mean, and
> > then reproducing that behaviour exactly in the new language.  The alternative
> > is fixing the problems as we convert, but then we end up with CML2 and the
> > "there's no way to verify the rulebase is the same" argument.
> 
> My only requirement is that the resulting rulebase is usable and roughly
> the same, some small bugs are IMO acceptable.

http://marc.theaimsgroup.com/?l=linux-kernel&m=101387128818052&w=2

> CML2 has more problems than this. 

Agreed.  I was just pointing out that one of the many objections to CML2
would also apply to any new language which wasn't provably mappable from
CML1.

> It's a very flexible but also very
> complex language, which makes it hard to use. It was also not very wise to
> create a complete new and different rulebase, which made it very hard to
> compare both.

Nor was it wise to use Python, and less so to insist on a cutting edge
version of Python, nor to throw away all the user interfaces, etc etc.
And don't even get me started on pickling and freezing.  Its very easy
to be wise in hindsight; let's use that wisdom to do better this time.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
