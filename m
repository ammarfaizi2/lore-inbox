Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUCSXOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUCSXOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:14:00 -0500
Received: from smtp03.web.de ([217.72.192.158]:33545 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263162AbUCSXN6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:13:58 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
Date: Sat, 20 Mar 2004 00:13:41 +0100
User-Agent: KMail/1.5.4
Cc: Philippe Elie <phil.el@wanadoo.fr>, Andrew Morton <akpm@osdl.org>,
       Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
References: <200403090014.03282.thomas.schlichter@web.de> <200403192001.13129.thomas.schlichter@web.de> <Pine.LNX.4.55.0403192116530.11965@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0403192116530.11965@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200403200013.42643.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 19. März 2004 21:30 schrieb Maciej W. Rozycki:
> On Fri, 19 Mar 2004, Thomas Schlichter wrote:
> > Well, my timer interrupt goes through the IO-APIC but I do have a
> > functional TSC. Nevertheless my system requires timer_ack to be set... If
> > it isn't, my CPU does not utilize its C2 state...
>
>  Hmm, I wonder if there's any relationship between the state of the local
> APIC and your observation.  Can you please see if the following hack
> changes anything (this assumes you have your timer IRQ directly connected
> to an I/O APIC input)?

I had to apply this hack by hand as your line numbers don't match mine (I use 
2.6.4-mm2) but I' sorry, this hack doesn't change anything for me... ;-(

   Thomas

