Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264799AbVBDNKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264799AbVBDNKk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264849AbVBDNKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:10:40 -0500
Received: from aun.it.uu.se ([130.238.12.36]:33528 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266284AbVBDNKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:10:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16899.29744.75308.6946@alkaid.it.uu.se>
Date: Fri, 4 Feb 2005 14:10:08 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Mikael Pettersson <mikpe@user.it.uu.se>, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 extended attributes refcounting wrong?
In-Reply-To: <1107513634.2245.46.camel@sisko.sctweedie.blueyonder.co.uk>
References: <16898.43219.133783.439910@alkaid.it.uu.se>
	<1107473817.2058.172.camel@sisko.sctweedie.blueyonder.co.uk>
	<16899.12681.98586.426731@alkaid.it.uu.se>
	<1107513634.2245.46.camel@sisko.sctweedie.blueyonder.co.uk>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie writes:
 > Hi,
 > 
 > On Fri, 2005-02-04 at 08:25, Mikael Pettersson wrote:
 > 
 > >  > In which kernel(s) exactly?  There was a fix for that applied fairly
 > >  > recently upstream.
 > > 
 > > I've been seeing this over the last couple of months, with
 > > (at least) 2.4.28 and newer, and 2.6.9 and newer standard kernels.
 > > But since I dual boot and switch kernels often, I can't point
 > > at any given kernel or kernel series as being the culprit.
 > 
 > Plain upstream 2.4.28?  If so, that's probably the trouble, as 2.4
 > doesn't have any xattr support, so if you delete a file on 2.4 it won't
 > delete the xattr block for it.

2.4.28 - certainly I've used that at lot.

 > > How recent was that fix? Maybe I'm seeing the aftereffects of
 > > pre-fix corruption?
 > 
 > It went in on the 15th of January this year.

Is it in 2.4.29?

/Mikael
