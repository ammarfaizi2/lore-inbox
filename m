Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWAQORs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWAQORs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWAQORs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:17:48 -0500
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:51643 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932507AbWAQORp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:17:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=tWGkfa5y5boUmQ5VTML62W9TQ4PiJBIKGcN3tfFIsIruZWTeKtVLvVZJEmABE4EWDzaKi7LiazhZ//Zzsd9ql3UfZsVrCAoyOBvd4b4IIc23eqxTlQpRnWFz7dRax06U2NQyh0QTufUa8fh6lAy+Y1oixU2Cq+CvtqXgJyEyJxE=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 9/11] UML - Implement soft interrupts
Date: Tue, 17 Jan 2006 15:17:37 +0100
User-Agent: KMail/1.8.3
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200601152139.k0FLdp1G027747@ccure.user-mode-linux.org> <200601170124.32076.blaisorblade@yahoo.it> <20060117033227.GB17171@ccure.user-mode-linux.org>
In-Reply-To: <20060117033227.GB17171@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601171517.38199.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 January 2006 04:32, Jeff Dike wrote:
> On Tue, Jan 17, 2006 at 01:24:31AM +0100, Blaisorblade wrote:
> > ~25 %? Good! Which is delay vs. host?
>
> Delay vs a UML without the patch.
>
> > A curiosity - did you look at the similar code in Ingo Molnar's VCPU
> > patch? I never found the time to split it out and compare differencies. I
> > just remember it using assembler inserts for (maybe atomic) bitmask
> > manipulations.
>
> It was separate from VCPU,
conceptually, but I got only a blob comprising everything - never seen it 
splitout (or maybe I split that out and forgot?)

> but I never really looked at it since I already 
> had this.  Some day I will to see if there are any trick in it that I
> should use.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
