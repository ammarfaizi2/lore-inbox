Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310545AbSCPTzB>; Sat, 16 Mar 2002 14:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310540AbSCPTyy>; Sat, 16 Mar 2002 14:54:54 -0500
Received: from ns.suse.de ([213.95.15.193]:15368 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310547AbSCPTym>;
	Sat, 16 Mar 2002 14:54:42 -0500
Date: Sat, 16 Mar 2002 20:54:40 +0100
From: Dave Jones <davej@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Gordon J Lee <gordonl@world.std.com>, linux-kernel@vger.kernel.org
Subject: Re: IBM x360 2.2.x boot failure, 2.4.9 works fine
Message-ID: <20020316205440.C15296@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Greg KH <greg@kroah.com>, Gordon J Lee <gordonl@world.std.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C927F3E.7C7FB075@world.std.com> <20020315234333.GH5563@kroah.com> <3C92B1EA.F40BDBD5@world.std.com> <20020316055542.GA8125@kroah.com> <3C938093.D1640CB6@world.std.com> <20020316173434.GB10003@kroah.com> <3C938693.6D29979C@world.std.com> <20020316194025.GA10571@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020316194025.GA10571@kroah.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 11:40:25AM -0800, Greg KH wrote:
 > > If so, at which 2.4.x kernel did support for hyperthreading show up?
 > In one of the 2.4.19-ac kernels from what I remember, sorry I don't know
 > the exact version.

 Interesting changelog entries..

2.4.14:   hyperthreaded P4's
2.4.17:- Pentium IV Hyperthreading support              (Alan Cox)
2.4.18ac:o      Hyperthreading awareness for MTRR driver

Shame that .14 and .17 aren't more descriptive. I'm guessing
that they provided different bits. Not sure from memory what order
things happened though.

Maybe .14 was "Boot, and don't do anything silly" patches, whilst
.17 was the actual "take advantage of this feature" patch.
 *shrug*


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
