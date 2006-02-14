Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030531AbWBNJf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030531AbWBNJf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030533AbWBNJf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:35:57 -0500
Received: from mail.charite.de ([160.45.207.131]:18922 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1030531AbWBNJf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:35:56 -0500
Date: Tue, 14 Feb 2006 10:35:53 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Zhu Yi <yi.zhu@intel.com>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc2-git8: ieee80211 does not compile
Message-ID: <20060214093553.GO29236@charite.de>
Mail-Followup-To: Zhu Yi <yi.zhu@intel.com>, linux-kernel@vger.kernel.org
References: <20060210123817.GQ6668@charite.de> <20060212104920.GU2690@charite.de> <1139897189.8403.71.camel@debian.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1139897189.8403.71.camel@debian.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zhu Yi <yi.zhu@intel.com>:
> On Sun, 2006-02-12 at 11:49 +0100, Ralf Hildebrandt wrote:
> >   CC [M]  net/ieee80211/ieee80211_module.o
> >   CC [M]  net/ieee80211/ieee80211_tx.o
> > net/ieee80211/ieee80211_tx.c: In function ieee80211_xmit':
> > net/ieee80211/ieee80211_tx.c:473: error: too few arguments to function
> 
> What's your build_iv() prototype (in ieee80211_crypt.h) looks like? You
> might be using some late ieee80211 updates which has not been merged to
> mainline yet.

I found it. You were right. I suck.

-- 
_________________________________________________

  Charité - Universitätsmedizin Berlin
_________________________________________________

  Ralf Hildebrandt
   i.A. Geschäftsbereich Informationsmanagement
   Campus Benjamin Franklin
   Hindenburgdamm 30 | Berlin
   Tel. +49 30 450 570155 | Fax +49 30 450 570962
   Ralf.Hildebrandt@charite.de
   http://www.charite.de
