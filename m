Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbVBDOSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbVBDOSX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 09:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbVBDORm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 09:17:42 -0500
Received: from aun.it.uu.se ([130.238.12.36]:36516 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265779AbVBDOQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 09:16:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16899.33676.414314.343747@alkaid.it.uu.se>
Date: Fri, 4 Feb 2005 15:15:40 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Mikael Pettersson <mikpe@user.it.uu.se>, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 extended attributes refcounting wrong?
In-Reply-To: <1107525405.2245.387.camel@sisko.sctweedie.blueyonder.co.uk>
References: <16898.43219.133783.439910@alkaid.it.uu.se>
	<1107473817.2058.172.camel@sisko.sctweedie.blueyonder.co.uk>
	<16899.12681.98586.426731@alkaid.it.uu.se>
	<1107513634.2245.46.camel@sisko.sctweedie.blueyonder.co.uk>
	<16899.29744.75308.6946@alkaid.it.uu.se>
	<1107525405.2245.387.camel@sisko.sctweedie.blueyonder.co.uk>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie writes:
 > Hi,
 > 
 > On Fri, 2005-02-04 at 13:10, Mikael Pettersson wrote:
 > 
 > >  > Plain upstream 2.4.28?  If so, that's probably the trouble, as 2.4
 > >  > doesn't have any xattr support, so if you delete a file on 2.4 it won't
 > >  > delete the xattr block for it.
 > > 
 > > 2.4.28 - certainly I've used that at lot.
 > 
 > But plain upstream 2.4.28, or a vendor kernel?  Like I just said,
 > upstream doesn't have xattr support.

Plain www.kernel.org kernels always.

/Mikael
