Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTLDTnI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 14:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTLDTnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 14:43:08 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:27554 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S261898AbTLDTnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 14:43:04 -0500
Date: Thu, 4 Dec 2003 14:41:48 -0500
Message-Id: <200312041941.hB4Jfm0E008607@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem 
In-reply-to: Your message of "Thu, 04 Dec 2003 18:20:05 GMT."
             <3FCF7AD5.4050501@lougher.demon.co.uk> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3FCF7AD5.4050501@lougher.demon.co.uk>, Phillip Lougher writes:
> Jörn Engel wrote:
> > 
> > So - as sick as it sounds - jffs2 may actually be the fs of choice
> > when doing encryption, even though working on a hard drive and not
> > flash.  Cool. :)
> > 
> 
> Considering that Jffs2 is the only writeable compressed filesystem, yes. 
[...]

Part of our stackable f/s project (FiST) includes a Gzipfs stackable
compression f/s.  There was a paper on it in Usenix 2001 and there's code in
the latest fistgen package.  See
http://www1.cs.columbia.edu/~ezk/research/fist/

Performance of Gzipfs is another matter, esp. for writes in the middle of
files. :-)

Cheers,
Erez.
