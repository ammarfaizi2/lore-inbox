Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTEMPUo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbTEMPT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:19:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24535 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261414AbTEMPTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:19:55 -0400
Date: Tue, 13 May 2003 17:32:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       Oleg Drokin <green@namesys.com>, lkhelp@rekl.yi.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030513153236.GB17033@suse.de>
References: <200305121455.58022.oliver@neukum.org> <Pine.SOL.4.30.0305121513270.18058-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0305121513270.18058-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12 2003, Bartlomiej Zolnierkiewicz wrote:
> On Mon, 12 May 2003, Oliver Neukum wrote:
> 
> > > Just a note that we have found TCQ unusable on our IBM drives and we had
> > > some reports about TCQ unusable on some WD drives.
> > >
> > > Unusable means severe FS corruptions starting from mount.
> > > So if your FSs will suddenly start to break, start looking for cause with
> > > disabling TCQ, please.
> >
> > I can confirm that. This drive Model=IBM-DTLA-307045, FwRev=TX6OA60A,
> > SerialNo=YMCYMT3Y229 has eaten my filesystem with TCQ on 2.5.69

Oliver, what hardware are you reproducing this on? The DTLA should work.

-- 
Jens Axboe

