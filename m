Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269392AbUINPB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269392AbUINPB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269378AbUINO7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:59:50 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:58248 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S269381AbUINO42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:56:28 -0400
Date: Tue, 14 Sep 2004 15:55:06 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Ville Hallivuori <vph@iki.fi>
cc: Toon van der Pas <toon@hout.vanvergehaald.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial
 of Service Attack
In-Reply-To: <20040913201113.GA5453@vph.iki.fi>
Message-ID: <Pine.LNX.4.61.0409141553260.23011@fogarty.jakma.org>
References: <002301c498ee$1e81d4c0$0200a8c0@wolf> <1095008692.11736.11.camel@localhost.localdomain>
 <20040912192331.GB8436@hout.vanvergehaald.nl> <Pine.LNX.4.61.0409130413460.23011@fogarty.jakma.org>
 <Pine.LNX.4.61.0409130425440.23011@fogarty.jakma.org> <20040913201113.GA5453@vph.iki.fi>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004, Ville Hallivuori wrote:

> Actually you can treat TCP session failure as transient error. Just 
> use BGP graceful restart (witch basically allows re-opening TCP 
> connection without losing routing tables).
>
> http://www.ietf.org/internet-drafts/draft-ietf-idr-restart-10.txt

Hmm, yes, I hadnt thought of the attack-mitigating aspects of 
graceful restart. Though, without other measures, the session is 
still is open to abuse (send RST every second).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Wit, n.:
 	The salt with which the American Humorist spoils his cookery
 	... by leaving it out.
 		-- Ambrose Bierce, "The Devil's Dictionary"
