Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266652AbUBMBwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 20:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266675AbUBMBwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 20:52:18 -0500
Received: from gaia.cela.pl ([213.134.162.11]:22291 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S266652AbUBMBwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 20:52:11 -0500
Date: Fri, 13 Feb 2004 02:52:02 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Michael Frank <mhf@linuxmail.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
In-Reply-To: <20040212153802.65adae84.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0402130244560.11774-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | +Usage of the apostrophe <'> in kernel messages is deprecated
> | +
> | +Mis-spellings allowed in kernel messages are:
> | +
> | +	dont, cant
> | +
> | +Printing numbers in parenthesis ie (%d) is deprecated
> 
> I don't know that we reached any concensus on these.  I think
> that these comments are just noise (IMO of course).
> I guess I'll spell out "do not" and "cannot".

Precisely - since are we supposed to now accept "Id" as "I'd", "Ill" as 
"I'll", etc?  What about cases where the apostrophe can't be decontracted 
- like Fred's source code - how do we remove the apostrophe there?  Change 
it to Freds?  That will likely in some cases change the meaning: it's/its, 
etc to name just one.

This is pointless - you won't manage to remove all single quotes anyway.

One side considers "dont" and "cant" to look like someone illiterate was 
typing and will do everything in their power to keep the quotes in and 
perceived spelling errors out.
The other side obviously considers any single quote to be a source of 
great eye discomfort will try for the opposite effect.

This is in many ways a pointless debate - you won't manage to convince 
people either one nor the other way.

These are comments - they can and often do contain 8-bit characters anyway 
- containing single quotes is not that great a problem - they already 
contain single backslashes - or should we escape those as well?

Cheers,
MaZe.


