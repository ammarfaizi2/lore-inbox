Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbTDCRDu 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261386AbTDCRDu 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:03:50 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:16750 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id S261385AbTDCRDr 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 12:03:47 -0500
Message-ID: <3E8C6C1E.8080901@acm.org>
Date: Thu, 03 Apr 2003 11:15:10 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Antonio Vargas <wind@cocodriloo.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: fairsched + O(1) process scheduler
References: <20030401125159.GA8005@wind.cocodriloo.com>	 <20030401164126.GA993@holomorphy.com>	 <20030401221927.GA8904@wind.cocodriloo.com>	 <20030402124643.GA13168@wind.cocodriloo.com>	 <20030402163512.GC993@holomorphy.com>	 <20030402213629.GB13168@wind.cocodriloo.com>	 <1049319300.2872.21.camel@localhost>	 <20030402220734.GC13168@wind.cocodriloo.com> <1049321427.2872.25.camel@localhost>
In-Reply-To: <1049321427.2872.25.camel@localhost>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Robert Love wrote:

>Yep.  Everyone architecture I know of - and certainly all that Linux
>support - can do atomic read/writes to a word.  Thinking about it, it
>would be odd if not (two writes to a single word interleaving?).  There
>are places this assumption is used.
>
I believe this is true if the data is aligned.  I don't think it's true
for unaligned access on an x86.

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+jGwdIXnXXONXERcRAg7NAJ9p3/dhYIvyQrUSR9RQhzOHebJxcQCgnnIt
TX41ng3GQo8SlGXLKmJvSKA=
=wjHE
-----END PGP SIGNATURE-----


