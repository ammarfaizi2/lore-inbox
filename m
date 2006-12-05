Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759892AbWLEV5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759892AbWLEV5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759939AbWLEV5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:57:14 -0500
Received: from wvmler2.mail.xerox.com ([13.8.138.217]:39603 "EHLO
	wvmler2.mail.xerox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759892AbWLEV5N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:57:13 -0500
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: ownership/permissions of cpio initrd
Date: Tue, 5 Dec 2006 16:56:26 -0500
Message-ID: <556445368AFA1C438794ABDA8901891C03445640@usa0300ms03.na.xerox.net>
In-Reply-To: <jehcwa13wv.fsf@sykes.suse.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ownership/permissions of cpio initrd
thread-index: AccYrGiza4dzJ199SgaJ2XAj8vva5AAA6Ubw
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: "Andreas Schwab" <schwab@suse.de>,
       "Marty Leisner" <linux@rochester.rr.com>
Cc: <linux-kernel@vger.kernel.org>, <bug-cpio@gnu.org>
X-OriginalArrivalTime: 05 Dec 2006 21:56:28.0750 (UTC) FILETIME=[377F7EE0:01C718B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmmm...I looked at that -- that's extract and passthrough, but not create...

I'll look at the other solutions...but the bottom line if you want to do root things, you need to
become root -- its always a better idea to munge bits than change permissions...so ANYONE can make
distributions with no special priveleges...


marty 

> -----Original Message-----
> From: Andreas Schwab [mailto:schwab@suse.de] 
> Sent: Tuesday, December 05, 2006 3:31 PM
> To: Marty Leisner
> Cc: linux-kernel@vger.kernel.org; bug-cpio@gnu.org; Leisner, Martin
> Subject: Re: ownership/permissions of cpio initrd
> 
> "Marty Leisner" <linux@rochester.rr.com> writes:
> 
> > Since a cpio is just a userspace created string of bits, I suppose
> > you can apply a set of ownership/permissions to files IN the archive
> > by playing with the bits...
> 
>   -R, --owner=[USER][:.][GROUP]   Set the ownership of all 
> files created to the
>                              specified USER and/or GROUP
> 
> Andreas.
> 
> -- 
> Andreas Schwab, SuSE Labs, schwab@suse.de
> SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
> PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 
> 214B 8276 4ED5
> "And now for something completely different."
> 
