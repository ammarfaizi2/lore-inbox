Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265130AbUE0UCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbUE0UCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 16:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbUE0UCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 16:02:07 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:16332 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265130AbUE0UCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 16:02:02 -0400
Date: Thu, 27 May 2004 14:01:59 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Valdis.Kletnieks@vt.edu
Cc: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: Re: CVS tags (was  Re: [Prism54-devel] Re: [PATCH 4/14 linux-2.6.7-rc1] prism54: add support for avs header in
Message-ID: <20040527200159.GP2603@schnapps.adilger.int>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	"Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	prism54-devel@prism54.org
References: <20040524083146.GE3330@ruslug.rutgers.edu> <40B631B3.4000902@pobox.com> <20040527191649.GT3330@ruslug.rutgers.edu> <200405271931.i4RJVjYB002642@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405271931.i4RJVjYB002642@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 27, 2004  15:31 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 27 May 2004 15:16:49 EDT, Luis R. Rodriguez said:
> > --- ksrc/islpci_eth.c
> > +++ ksrc-new/islpci_eth.c
> 
> I think this was what he referred to:
> 
> >-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.31 2004/03 15:27:44 ajfa Exp $
> >+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.33 2004/03/19 23:03:58 ajfa Exp $
> 
> as this will almost surely cause rejects (sooner or later) unless 100% of your
> patches are applied and in the right order.

This also causes grief if this file is ever imported again into a CVS-based
SCM, unless you remember to do so with -ko.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

