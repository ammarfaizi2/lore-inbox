Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290186AbSALA1e>; Fri, 11 Jan 2002 19:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290185AbSALA1S>; Fri, 11 Jan 2002 19:27:18 -0500
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:54198 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S290183AbSALA06>; Fri, 11 Jan 2002 19:26:58 -0500
Message-ID: <3C3F8377.8010603@wanadoo.fr>
Date: Sat, 12 Jan 2002 01:29:43 +0100
From: eddantes@wanadoo.fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
CC: Daniel Phillips <phillips@bonn-fries.net>, Dan Kegel <dank@kegel.com>,
        "Timothy D. Witham" <wookie@osdl.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Mike Galbraith <mikeg@wen-online.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stp@osdl.org
Subject: Re: Regression testing of 2.4.x before release?
In-Reply-To: <Pine.LNX.4.33.0201111600560.19843-100000@shell1.aracnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


M. Edward (Ed) Borasky wrote:

[snip]

> One particular application for which gcc 3.x *and* gcc 2.96.x are
> seriously deficient, at least on Intel/AMD 32-bit systems, is the
> high-performance linear algebra library Atlas. As a result, *my* default
> for compiling numerical applications is the Atlas-recommended one,
> 2.95.3. For the kernel, I use whatever the Red Hat 7.2 default is.
> 

Mmhh... Just remember gcc 2.96.x is NOT a regular gcc release, you can 
check at:
http://www.gnu.org/software/gcc/releases.html
AFAIK, it is a RH-hacked pre-3.0, which is probably not the best thing 
to use for anything.

The 3.x series are know to generate pretty slow code, anyway. So I bet 
your experience is pretty normal. I still stick with 2.95.[34] for x86 
kernel compile, although I'm using 3.0 for all purposes on Hitashi SH, 
as only gcc>=3.0 correctly supports the sh4.

/dantes

