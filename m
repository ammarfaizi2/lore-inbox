Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVCSKW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVCSKW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 05:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVCSKW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 05:22:56 -0500
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:36066 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S262440AbVCSKWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 05:22:51 -0500
Date: Sat, 19 Mar 2005 11:22:50 +0100
From: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 3c59x concerns on 2.4->2.6 update?
Message-ID: <20050319102250.GA11557@bayes.mathematik.tu-chemnitz.de>
Mail-Followup-To: Matthias Andree <matthias.andree@gmx.de>,
	linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20050318103418.GA14636@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318103418.GA14636@merlin.emma.line.org>
User-Agent: Mutt/1.4.2.1i
X-Spam-Score: -2.8 (--)
X-Spam-Report: --- Start der SpamAssassin 3.0.2 Textanalyse (-2.8 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	-2.8 ALL_TRUSTED            Nachricht wurde nur ueber vertrauenswuerdige Rechner weitergeleitet
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: a37c3661e0372786d6c154dc38711565
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.11 ethtool data should be available. Please let me know if
you are using 2.6.11 and ethtool does not work with your card. 

I have no Tornado card to test but with 3c905/3c905B cards and 
options=0x204 configured, mii-diag reports:
Auto-negotiation disabled, with Speed fixed at 100 mbps, full-duplex.

I suppose you talking about 3c905C Tornado cards 
(3c900 cards are not of Tornado type).

Steffen

On Fri, Mar 18, 2005 at 11:34:19AM +0100, Matthias Andree wrote:
> Hi,
> 
> I've recently upgraded a router which has three 3Com900C Tornado cards
> revisions 74 and 78 from Linux 2.4 to 2.6.
> 
> IIRC, Linux 2.4 allowed to report if the link beat was sensed to be 10
> or 100 mbps, Linux 2.6 does not. One of these cards is attached to
> peculiar network gear and needs to be forced to 100baseTx-FD.
> I configured options=0x204 for that interface, which sorta worked;
> vortex-diag and mii-diag still report autonegotiation were enabled.
> Strange.
> 
> ethtool (I tried v2 and v3) does not appear to work at all for 3C900C
> cards, "No data available" if run without options.
> 
> Any insight into these would be appreciated,
> 
> -- 
> Matthias Andree
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
