Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTKKCyG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 21:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264225AbTKKCyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 21:54:06 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:9669 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261719AbTKKCyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 21:54:04 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Joseph Shamash" <info@avistor.com>
Date: Tue, 11 Nov 2003 13:53:46 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16304.20282.545345.360177@notabene.cse.unsw.edu.au>
Cc: "Peter Chubb" <peter@chubb.wattle.id.au>, <linux-kernel@vger.kernel.org>
Subject: RE: 2 TB partition support
In-Reply-To: message from Joseph Shamash on Monday November 10
References: <16304.19406.995702.451479@wombat.chubb.wattle.id.au>
	<HBEHKOEIIJKNLNAMLGAOMEDBDKAA.info@avistor.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 10, info@avistor.com wrote:
> 
> >I've only created a 2.4.20 patch;...
> 
> I seem to remember there was a bug for the 2.4.20 kernel. IIRC, it had
> something to do with unmounting a filesystem and losing data, if the data
> was still in the cache. Is this true? Can I find a patch for this, if it is
> true?
> 

Only true (as far as I know) if using ext3 (and possibly other restrictions).

Patches at:
http://www.zipworld.com.au/~akpm/linux/ext3/

NeilBrown
