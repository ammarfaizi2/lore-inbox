Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266260AbUBLApg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 19:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266264AbUBLApg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 19:45:36 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:62006 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S266260AbUBLApe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 19:45:34 -0500
Date: Wed, 11 Feb 2004 18:45:32 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040212004532.GB29952@hexapodia.org>
References: <20040209115852.GB877@schottelius.org> <slrn-0.9.7.4-32556-23428-200402111736-tc@hexane.ssi.swin.edu.au> <1076517309.21961.169.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076517309.21961.169.camel@shaggy.austin.ibm.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 10:35:10AM -0600, Dave Kleikamp wrote:
> Yeah, JFS has poor default behavior based on CONFIG_NLS_DEFAULT.  I
> attempted to explain why it works that way in the first bug listed above
> if anyone is curious.

I think your suggested fix is good, but it begs the question:

Why on earth is JFS worried about the filename, anyways?  Why has it
*ever* had *any* behavior other than "string of bytes, delimited with /,
terminated with \0" ?

I read your response about OS/2, and maybe I'm just slow, but I don't
see what that has to do with anything.

Does JFS on AIX have the same buggy behavior?

What behavior was the code originally designed to implement, on OS/2?
Why was that behavior chosen rather than "filenames are a string of
bytes"?

Feel free to point to a "Design of the OS/2 JFS interface" document if
such exists and answers my question. :)

-andy
