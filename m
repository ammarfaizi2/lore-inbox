Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVAGDax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVAGDax (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 22:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVAGDaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 22:30:52 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:21709 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S261269AbVAGDal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 22:30:41 -0500
Date: Thu, 06 Jan 2005 22:30:27 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
In-reply-to: <20050107002624.GA29006@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       paulmck@us.ibm.com, arjan@infradead.org, linux-kernel@vger.kernel.org,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
Message-id: <41DE0253.6090208@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050106190538.GB1618@us.ibm.com>
 <1105039259.4468.9.camel@laptopd505.fenrus.org>
 <20050106201531.GJ1292@us.ibm.com>
 <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
 <20050106210408.GM1292@us.ibm.com>
 <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
 <20050106152621.395f935e.akpm@osdl.org> <20050106234123.GA27869@infradead.org>
 <20050106162928.650e9d71.akpm@osdl.org> <20050107002624.GA29006@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig wrote:
> On Thu, Jan 06, 2005 at 04:29:28PM -0800, Andrew Morton wrote:
> 
>>Fine.  Completely agree.  Sometimes people do need to be forced to make
>>such changes - I don't think anyone would disagree with that.
>>
>>What's under discussion here is "how to do it".  Do we just remove things
>>when we notice them, or do we give (say) 12 months notice?
> 
> 
> Remove when we notice with a short (measured in weeks) period where that
> removal happens only in -mm.  It's a price people have to pay for not
> submitting their code upstream.

Not everyone has cycles to follow to -mm.

I'd much rather see deprecation warnings in mainline releases for at
least one if not two releases.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3gJTdQs4kOxk3/MRAq9uAKCRHF7aF/vviLfIQl3fvv4eZSYpCACgh82/
5aTd4a6BqeGISYPZDDUvhSg=
=mhET
-----END PGP SIGNATURE-----
