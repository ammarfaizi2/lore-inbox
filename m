Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269593AbUINQnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269593AbUINQnX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 12:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269461AbUINQkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:40:52 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:47752 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S269592AbUINQ04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:26:56 -0400
Date: Tue, 14 Sep 2004 17:26:24 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ville Hallivuori <vph@iki.fi>,
       Toon van der Pas <toon@hout.vanvergehaald.nl>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial
 of Service Attack
In-Reply-To: <1095174633.16990.19.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0409141721270.23011@fogarty.jakma.org>
References: <002301c498ee$1e81d4c0$0200a8c0@wolf> 
 <1095008692.11736.11.camel@localhost.localdomain>  <20040912192331.GB8436@hout.vanvergehaald.nl>
  <Pine.LNX.4.61.0409130413460.23011@fogarty.jakma.org> 
 <Pine.LNX.4.61.0409130425440.23011@fogarty.jakma.org>  <20040913201113.GA5453@vph.iki.fi>
  <Pine.LNX.4.61.0409141553260.23011@fogarty.jakma.org>
 <1095174633.16990.19.camel@localhost.localdomain>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004, Alan Cox wrote:

> guess them that way. This is spectacularly more effective and 
> various vendors highly invalid rst acking crap won't save you.

Ah, well, I dont care about various vendors. I only care about Linux, 
BSD and SunOS kernel behaviour ;)

That said, TCP-MD5 signature renders this mostly moot, and deployment 
of TCP-MD5 has increased a lot since the last round of "BGP TCP is 
insecure!" non-issues came up. Many IXes and peers now require 
TCP-MD5.

The rights and wrongs of TCP-MD5 notwithstanding, it'd be nice if 
Linux could support this. Anyone running BGP on Linux at moment must 
patch their kernel - or else just switch to Free/Open BSD.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
It looks like it's up to me to save our skins.  Get into that garbage chute,
flyboy!
 		-- Princess Leia Organa
