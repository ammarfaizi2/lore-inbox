Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWBGJp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWBGJp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWBGJp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:45:27 -0500
Received: from ns.firmix.at ([62.141.48.66]:21902 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S964820AbWBGJp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:45:26 -0500
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
From: Bernd Petrovitsch <bernd@firmix.at>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Arjan van de Ven <arjan@infradead.org>, Mark Lord <lkml@rtr.ca>,
       Ulrich Mueller <ulm@kph.uni-mainz.de>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060207004147.GA21620@MAIL.13thfloor.at>
References: <43C40803.2000106@rtr.ca>
	 <20060201222314.GA26081@MAIL.13thfloor.at>
	 <uhd7irpi7@a1i15.kph.uni-mainz.de>
	 <Pine.LNX.4.61.0602022144190.30391@yvahk01.tjqt.qr>
	 <43E3DB99.9020604@rtr.ca>
	 <Pine.LNX.4.61.0602041204490.30014@yvahk01.tjqt.qr>
	 <1139153913.3131.42.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0602052212430.330@yvahk01.tjqt.qr>
	 <1139174355.3131.50.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0602061554550.31522@yvahk01.tjqt.qr>
	 <20060207004147.GA21620@MAIL.13thfloor.at>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 07 Feb 2006 10:38:05 +0100
Message-Id: <1139305085.13091.17.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 01:41 +0100, Herbert Poetzl wrote:
> On Mon, Feb 06, 2006 at 03:56:34PM +0100, Jan Engelhardt wrote:
[...]
> > 
> > So, just as I did in the sample patch, the manual split shall depend on 
> > EMBEDDED. Those who run fat databases with big malloc/mmap assumptions 
> > don't probably belong to the group using CONFIG_EMBEDDED.
> 
> *sigh* well, the embeded folks are unlikely to have 1-3GB

ACK.
But don't be confused by the naming: CONFIG_EMBEDDED nowadays means
"options for people who know really what they do". It came originally
from the embedded world but applies now also to others. 
No one has come up with a better option name up to now ...

> why not use EXPERIMENTAL if you 'think' the option will
> hurt the database folks who do not know to configure their
> kernel ...

EXPERIMENTAL means (at least for me) "this may not really work" and is
IMHO orthogonal to CONFIG_EMBEDDED.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

