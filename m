Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSFQODQ>; Mon, 17 Jun 2002 10:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSFQODP>; Mon, 17 Jun 2002 10:03:15 -0400
Received: from ns.suse.de ([213.95.15.193]:1554 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S313867AbSFQODO>;
	Mon, 17 Jun 2002 10:03:14 -0400
Date: Mon, 17 Jun 2002 16:03:15 +0200
From: Dave Jones <davej@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW SUBARCHITECTURE FOR 2.5.21] support for NCR voyager (3/4/5xxx series)
Message-ID: <20020617160315.B758@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	linux-kernel@vger.kernel.org
References: <davej@suse.de> <200206140013.g5E0DQR25561@localhost.localdomain> <20020614024547.H16772@suse.de> <20020614134152.GA1293@pazke.ipt> <20020614154945.M16772@suse.de> <20020614135229.GA313@pazke.ipt> <20020614161627.O16772@suse.de> <20020617133632.GA3270@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020617133632.GA3270@pazke.ipt>; from pazke@orbita1.ru on Mon, Jun 17, 2002 at 05:36:32PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 05:36:32PM +0400, Andrey Panin wrote:

 > >  > >  > "Latest" (2.4.17) visws patch which i'm planning to convert for 25, uses
 > >  > >  > function MP_processor_info() from generic mpparse.c. May be it makes sence
 > >  > >  > to move to some generic file ?
 > >  > > Is that the one from the visws sourceforge project ?
 > >  > Yes it is.
 > > 
 > > Ah good. *cross item off TODO list*
 >  
 > Does it make sense to submit it right now before i386 arch split will
 > be completed ?

I took a quick look over James' current patch last night. In it's
current state, I think it's quite large already, and as it touches
so many areas, I'm wondering if it's possible to split it up into
chunks and merge it gradually.

merging visws now would mean a large part of James' current work
would be out of sync.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
