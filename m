Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318140AbSG2Xmp>; Mon, 29 Jul 2002 19:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318141AbSG2Xmp>; Mon, 29 Jul 2002 19:42:45 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:501 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318140AbSG2Xmo>; Mon, 29 Jul 2002 19:42:44 -0400
Date: Mon, 29 Jul 2002 17:44:10 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Jan Hudec <bulb@ucw.cz>, linux-fsdevel@sd3.mailbank.com,
       linux-kernel@vger.kernel.org, "Peter J. Braam" <braam@clusterfs.com>
Subject: Re: Race in open(O_CREAT|O_EXCL) and network filesystem
Message-ID: <20020729234410.GD3077@clusterfs.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Jan Hudec <bulb@ucw.cz>, linux-fsdevel@sd3.mailbank.com,
	linux-kernel@vger.kernel.org,
	"Peter J. Braam" <braam@clusterfs.com>
References: <20020728165256.GA4631@vagabond> <15685.11287.43065.570783@notabene.cse.unsw.edu.au> <20020729150211.GC3077@clusterfs.com> <15685.51699.423140.374908@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15685.51699.423140.374908@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 30, 2002  09:04 +1000, Neil Brown wrote:
> On Monday July 29, adilger@clusterfs.com wrote:
> > The intent-based lookup code is available as part of the Lustre CVS.
> > See lustre/patches/patch-2.4.18 at the SF lustre project.  There are
> > a couple of other changes in the patch that are unrelated to intents,
> > but those are fairly obvious (i.e. ext3/jbd changes, some exports, etc).
> 
> Thanks.  I've found it.  I might have a read through some time.
> Is there any plan (or likelyhood) for this getting into 2.5?

Well, we plan to submit it for 2.5, but no work has been done in that
direction yet.  I believe Peter has an agreement-in-principle with Al
on this, but I don't think Al has seen the code yet.  We want to make
sure that we don't need any major changes before it is submit it.  So
far the current patch is working well for us.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

