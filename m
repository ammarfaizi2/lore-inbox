Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVHYC1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVHYC1G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 22:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVHYC1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 22:27:06 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:55313 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932490AbVHYC1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 22:27:05 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "Andy Isaacson" <adi@hexapodia.org>
Cc: "moreau francis" <francis_moreau2000@yahoo.fr>,
       <linux-kernel@vger.kernel.org>
Subject: RE: question on memory barrier
Date: Wed, 24 Aug 2005 19:25:51 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEMHGBAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
In-Reply-To: <Pine.LNX.4.61.0508241559450.31759@chaos.analogic.com>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 24 Aug 2005 19:23:52 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 24 Aug 2005 19:23:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Wrong. Reference:
>
> http://www.phy.duke.edu/~rgb/General/c_book/c_book/chapter8/sequen
> ce_points.html
>
> Cheers,
> Dick Johnson

	That discussion is wrong. The form of the argument is simply invalid.

	Just because an optimization could break things in some cases doesn’t mean
the compiler can’t ever make the optimization. It just can’t make the
optimization in the case that breaks things. And by “things” I mean things
that are defined in the standard that would be broken, not things outside of
it.

	DS


