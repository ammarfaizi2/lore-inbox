Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWGaReI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWGaReI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWGaReH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:34:07 -0400
Received: from mail.gmx.net ([213.165.64.21]:63195 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030281AbWGaReG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:34:06 -0400
X-Authenticated: #428038
Date: Mon, 31 Jul 2006 19:34:00 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Dan Oglesby <doglesby@teleformix.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060731173400.GA9466@merlin.emma.line.org>
Mail-Followup-To: Dan Oglesby <doglesby@teleformix.com>,
	Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
	ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
	jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <1153760245.5735.47.camel@ipso.snappymail.ca> <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl> <20060731125846.aafa9c7c.reiser4@blinkenlights.ch> <20060731144736.GA1389@merlin.emma.line.org> <20060731175958.1626513b.reiser4@blinkenlights.ch> <20060731162224.GJ31121@lug-owl.de> <1154364421.7964.22.camel@localhost> <20060731171620.GL31121@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731171620.GL31121@lug-owl.de>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw schrieb am 2006-07-31:

> Uh?  Where did you face a problem there?
> 
> With maildir, you shouldn't face any problems IMO. Even users with
> zillions of mails should work properly with the dir_index stuff:
> 
> 	tune2fs -O dir_index /dev/hdXX
> 
> or alternatively (to start that for already existing directories):
> 
> 	e2fsck -fD /dev/hdXX

hat is not "alternatively", but "tune2fs first", then "e2fsck -fD"
(which can't happen on a RW-mounted FS and you should only try this on
your rootfs if you can reboot with magic sysrq or from a rescue system).

-- 
Matthias Andree
