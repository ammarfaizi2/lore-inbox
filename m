Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUGNK2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUGNK2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 06:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267355AbUGNK2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 06:28:55 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:1508 "EHLO
	mailrelay1.nefonline.de") by vger.kernel.org with ESMTP
	id S267354AbUGNK2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 06:28:53 -0400
Date: Wed, 14 Jul 2004 12:28:49 +0200
From: Hermann Gottschalk <hg@ostc.de>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange Network behaviour
Message-ID: <20040714102849.GD11727@ostc.de>
References: <20040702153028.GD15170@ostc.de> <20040704164654.GA18688@outpost.ds9a.nl> <20040714080036.GC11178@ostc.de> <20040714090208.GA2274@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040714090208.GA2274@k3.hellgate.ch>
User-Agent: Mutt/1.4.1i
X-PGP-Key: 1024D/0B2D8EEA 2004-06-07 Hermann Gottschalk (OSTC) <hg@ostc.de>
X-PGP-Fingerprint: 9A36 D20E B7FB BE5D 11DB  3006 3ADA D083 0B2D 8EEA
X-Operating-System: Linux 2.4.21-231-default
X-message-flag: Please do NOT send HTML e-mail or MS Word attachments - use plain text instead
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 11:02:08AM +0200, Roger Luethi wrote:
> On Wed, 14 Jul 2004 10:00:36 +0200, Hermann Gottschalk wrote:
> > OK, now after an "update" to 2.4.21-231 (SuSE 9.0) some similar
> > Errors occur:
> > 
> > 1) The via-rhine IF isn't accessible anymore. It's up but doesn't work.
> > 
> > 2) We work with lvm and lvm-snapshots can't be removed anymore. I
> >    get a segmentation fault.
> 
> Looks like you have more than one problem. The lvm related trace is
> hardly due to via-rhine (and you need to send it through ksymoops
> to get something useful).
> 
> If you set debug in via-rhine to 3, you'll get a more interesting
> log. Does booting with noacpi help at all?

I will try noapic.

Could it be a problem with lvm and nfs? 

The nfs-connection is sometimes very slow even there is no
networkproblem on the e1000-IFs...

-- 
  ___  ___ _____ ___    ___       _    _  _
 / _ \/ __|_   _/ __|  / __|_ __ | |__| || |
| (_) \__ \ | || (__  | (_ | '  \| '_ \ __ |
 \___/|___/ |_| \___|  \___|_|_|_|_.__/_||_|
----------------------------------------------
 OSTC Open Source Training and Consulting GmbH
 90425 Nürnberg      Web:   http://www.ostc.de
----------------------------------------------
            PGP-Key: 0x0B2D8EEA 
    No HTML-Mails; 72 Characters per line
