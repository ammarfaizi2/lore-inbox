Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318789AbSHLSDE>; Mon, 12 Aug 2002 14:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318790AbSHLSDE>; Mon, 12 Aug 2002 14:03:04 -0400
Received: from hercules.egenera.com ([208.254.46.135]:49934 "HELO
	coyote.egenera.com") by vger.kernel.org with SMTP
	id <S318789AbSHLSDE>; Mon, 12 Aug 2002 14:03:04 -0400
Date: Mon, 12 Aug 2002 14:06:33 -0400
From: Phil Auld <pauld@egenera.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: viro@math.psu.edu, marcelo@connectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19 revert block_llseek behavior to standard
Message-ID: <20020812140633.H27650@vienna.EGENERA.COM>
References: <20020812120659.B27650@vienna.EGENERA.COM> <1029169257.16424.176.camel@irongate.swansea.linux.org.uk> <20020812123632.E27650@vienna.EGENERA.COM> <1029172448.16424.178.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1029172448.16424.178.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Aug 12, 2002 at 06:14:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rumor has it that on Mon, Aug 12, 2002 at 06:14:08PM +0100 Alan Cox said:
> On Mon, 2002-08-12 at 17:36, Phil Auld wrote:
> > > Political I don't see any. Technical - have you verified each of our
> > > block drivers behaves correctly when given an offset over its side, and
> > > that it correctly fails on a 32bit block wrap.
> > > 
> > 
> > No, but how did it work prior to 2.4.11?
> 
> Did it work correctly - the answer I believe is - no it didnt.
> 
> 

It may not have worked in all cases but it did observe standard 
specified behavior.

Phil


> Alan

-- 
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St., Marlboro, MA 01752       (508)858-2600
