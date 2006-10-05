Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751751AbWJERpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbWJERpV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbWJERpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:45:21 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:42988 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751751AbWJERpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:45:18 -0400
Message-ID: <452544AC.7050906@garzik.org>
Date: Thu, 05 Oct 2006 13:45:16 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
References: <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <20061003231648.GB26351@thunk.org> <1159948179.2817.26.camel@ux156> <20061005163513.GC6510@bougret.hpl.hp.com> <4525364D.1000409@garzik.org> <20061005174241.GA23632@codepoet.org>
In-Reply-To: <20061005174241.GA23632@codepoet.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Thu Oct 05, 2006 at 12:43:57PM -0400, Jeff Garzik wrote:
>> Wireless Extensions has reached end-of-life, and so we only need to
>> support what's out there in wide distribution.
> 
> Hmm, so what is going to replace it?  I was messing about with my
> old powerbook G4 titanium, trying to make wpa_supplicant work
> when I realized the airport/orinoco driver used for my powerbook
> can't handle WPA since that apparently requires at least WE-18.
> I started looking into what it would take to teach the orinoco
> driver about WE>=18.  But I suppose there is no point in my
> looking further if WE is heading to the great bit-bucket in the
> sky.
> 
> Is 'Wireless Extensions The Next Generation' described and
> documented somewhere?  Or am I better off if I just give up and
> move on to some other more realistic project?  :-)

Look around for references to nl80211 / cfg80211, particularly on the 
netdev@vger.kernel.org list.

	Jeff


P.S.  Your mailer is generating buggy Mail-Followup-To lines.
