Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760040AbWLCTy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760040AbWLCTy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 14:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760044AbWLCTy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 14:54:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29128 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1760040AbWLCTy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 14:54:26 -0500
Date: Sun, 3 Dec 2006 19:54:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Russell Cattelan <cattelan@redhat.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [Cluster-devel] Re: [GFS2] Change argument of gfs2_dinode_out [17/70]
Message-ID: <20061203195422.GA9762@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Russell Cattelan <cattelan@redhat.com>,
	Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
References: <1164888933.3752.338.camel@quoit.chygwyn.com> <1165000744.1194.89.camel@xenon.msp.redhat.com> <20061201192555.GD3078@ftp.linux.org.uk> <1165006331.1194.96.camel@xenon.msp.redhat.com> <20061201210849.GF3078@ftp.linux.org.uk> <1165015786.1194.133.camel@xenon.msp.redhat.com> <20061202011043.GG3078@ftp.linux.org.uk> <4573204D.4070608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4573204D.4070608@redhat.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2006 at 01:06:53PM -0600, Russell Cattelan wrote:
> Ok your right rhel5 has no bearing on what goes into 2.6.20.
> And again I not taking issues with any of the cleanups you sent
> in they were complete and addressed real potential problems.
> 
> Just trying to point out stablizing and bug fixing  over partial 
> cleanups would be more helpful
> for gfs2 in general,  for whatever kernel it is running in.

The right thing would have been to no put in gfs2 too early.  According
to you it's unstable, it's not endian annotated which is mormally required
and I can't remember a filesystem developer doing a full review of it either.

Unfortunately your employer pushed it very hard and got it in prematurely.

