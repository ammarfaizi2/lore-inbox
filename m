Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272380AbTHECpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 22:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272384AbTHECpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 22:45:44 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:34009 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S272380AbTHECpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 22:45:42 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Stephan von Krawczynski <skraw@ithnet.com>
Date: Tue, 5 Aug 2003 12:45:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16175.6729.962817.135747@gargle.gargle.HOWL>
Cc: Jeff Muizelaar <muizelaar@rogers.com>, linux-kernel@vger.kernel.org,
       mru@users.sourceforge.net
Subject: Re: FS: hardlinks on directories
In-Reply-To: message from Stephan von Krawczynski on Monday August 4
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<yw1xsmohioah.fsf@users.sourceforge.net>
	<20030804152226.60204b61.skraw@ithnet.com>
	<3F2E7C63.2000203@rogers.com>
	<20030804181500.074aec51.skraw@ithnet.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday August 4, skraw@ithnet.com wrote:
> On Mon, 04 Aug 2003 11:31:47 -0400
> Jeff Muizelaar <muizelaar@rogers.com> wrote:
> 
> > Stephan von Krawczynski wrote:
> > 
> > >
> > >I guess this is not really an option if talking about hundreds or thousands
> > >of"links", is it?
> > >  
> > >
> > actually hundreds or thounds still should be ok. See...
> 
> Hm, and I just found out that re-exporting "mount --bind" volumes does not work
> over nfs...
> 
> Is this correct, Neil?

Yes, though there is a reasonable chance that it can be made to work
with linux-2.6.0 and nfs-utils-1.1.0 (neither of which have been
released yet:-)

But I'm a big fan of auto-mounters - e.g. am-utils.

If you want a filesystem that is assembled from lots of bits of other
filesystem, describe it to am-utils and it will present it to you.

NeilBrown
