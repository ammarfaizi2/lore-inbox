Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318222AbSHZTCh>; Mon, 26 Aug 2002 15:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318252AbSHZTCg>; Mon, 26 Aug 2002 15:02:36 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:6910 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318222AbSHZTBu>; Mon, 26 Aug 2002 15:01:50 -0400
Subject: Re: Linux 2.4.20-pre4-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Daniel Egger <degger@fhm.edu>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020826200623.1556@192.168.4.1>
References: <1030379037.17690.8.camel@sonja.de.interearth.com> 
	<20020826200623.1556@192.168.4.1>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 20:06:28 +0100
Message-Id: <1030388788.2797.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 21:06, Benjamin Herrenschmidt wrote:
> >What are your plans to visualise the gmac removal in the config?
> >At the moment it's not exactly obvious that sungem will work
> >in place for gmac.
> 
> Not too sure about that, though Tom Rini sent me a patch that
> will "upgrade" an existing config, I may just merge that and
> remove the visible option.

If it was x86 I'd say "keep it for 2.4, delete it in 2.5, in the 2.4 one
add a printk advising people to switch driver". I don't know how the ppc
world is accustomed to handling this though

