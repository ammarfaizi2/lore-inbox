Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVB1QpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVB1QpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVB1QpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:45:11 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:3259 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261679AbVB1QpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:45:03 -0500
Date: Mon, 28 Feb 2005 17:45:00 +0100
To: Gerd Knorr <kraxel@bytesex.org>
Cc: James Bruce <bruce@andrew.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
Message-ID: <20050228164459.GI21514@vanheusden.com>
References: <422001CD.7020806@andrew.cmu.edu> <20050228134410.GA7499@bytesex> <42232DFC.6090000@andrew.cmu.edu> <87mzto3c78.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mzto3c78.fsf@bytesex.org>
Organization: www.unixexpert.nl
Read-Receipt-To: <folkert@vanheusden.com>
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Tue Mar  1 11:36:10 CET 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
From: folkert@vanheusden.com (Folkert van Heusden)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, are there any theories as to why it would work flawlessly, then
> > after a hard lockup (due to what I think is a buggy V4L2 application),
> > that the cards no longer work?
> No idea why the eeprom doesn't respond any more.  Maybe it's really
> broken.  Note that the eeprom is read only at insmod time (and even
> that for some cards only), thus there isn't a clear connection between
> the crash and the eeprom issue.  It could have died earlied unnoticed.
> The eeprom holds the PCI Subsystem ID, so without a working eeprom
> bttv can't figure automatically what exact card that is (see the
> "unknown/default" card name in the log) and maybe thats why does not
> work any more for the card in question.  Thats should be easily
> fixable using the card= insmod option.

I remember something about that you shouldn't use the teletext-decoder
at the same time as viewing regular tv. That would damage the eeprom.
Maybe it is related?


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!
