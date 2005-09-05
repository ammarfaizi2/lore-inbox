Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbVIEUxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbVIEUxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 16:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVIEUxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 16:53:53 -0400
Received: from shill.XCF.Berkeley.EDU ([128.32.112.247]:45778 "EHLO
	wilber.gimp.org") by vger.kernel.org with ESMTP id S1750945AbVIEUxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 16:53:53 -0400
Date: Mon, 5 Sep 2005 13:53:51 -0700
From: Kurt Hackel <kurt.hackel@oracle.com>
To: Bernd Eckenfels <be-mail2005@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GFS, what's remaining
Message-ID: <20050905205351.GB21169@gimp.org>
References: <20050903070639.GC4593@ca-server1.us.oracle.com> <E1EBSRB-0003lW-00@calista.eckenfels.6bone.ka-ip.net> <20050905141631.GG5498@marowsky-bree.de> <20050905202403.GB7580@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905202403.GB7580@lina.inka.de>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 10:24:03PM +0200, Bernd Eckenfels wrote:
> On Mon, Sep 05, 2005 at 04:16:31PM +0200, Lars Marowsky-Bree wrote:
> > That is the whole point why OCFS exists ;-)
> 
> The whole point of the orcacle cluster filesystem as it was described in old
> papers was about pfiles, control files and software, because you can easyly
> use direct block access (with ASM) for tablespaces.

The original OCFS was intended for use with pfiles and control files but
very definitely *not* software (the ORACLE_HOME).  It was not remotely
general purpose.  It also predated ASM by about a year or so, and the
two solutions are complementary.  Either one is a good choice for Oracle
datafiles, depending upon your needs.

> > No. Beyond the table spaces, there's also ORACLE_HOME; a cluster
> > benefits in several aspects from a general-purpose SAN-backed CFS.
> 
> Yes, I dont dispute the usefullness of OCFS for ORA_HOME (beside I think a
> replicated filesystem makes more sense), I am just nor sure if anybody sane
> would use it for tablespaces.

Too many to mention here, but let's just say that some of the largest
databases are running Oracle datafiles on top of OCFS1.  Very large
companies with very important data.

> I guess I have to correct the artile in my german it blog :) (if somebody
> can name productive customers).

Yeah you should definitely update your blog ;-)  If you need named
references, we can give you loads of those.

-kurt

Kurt C. Hackel
Oracle
kurt.hackel@oracle.com
