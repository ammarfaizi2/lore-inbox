Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbULAUcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbULAUcl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 15:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbULAUch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 15:32:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59626 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261434AbULAUce
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 15:32:34 -0500
Date: Wed, 1 Dec 2004 20:32:26 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Jose R. Santos" <jrsantos@austin.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: phase change messages cusing slowdown with sym53c8xx_2 driver
Message-ID: <20041201203226.GI5752@parcelfarce.linux.theplanet.co.uk>
References: <20041130030212.GB22916@austin.ibm.com> <20041201165654.GA32687@rx8.austin.ibm.com> <1101921398.1930.24.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101921398.1930.24.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 12:16:33PM -0500, James Bottomley wrote:
> does this look like the "drive won't respond properly to PPR if the bus
> is SE" problem again?

Thomas Babut who tested that fix reported it didn't solve his problem ;-(

http://marc.theaimsgroup.com/?l=linux-scsi&m=109968716312783&w=2
http://marc.theaimsgroup.com/?l=linux-scsi&m=109969829411685&w=2

I'm out of ideas for fixing that one.  Would you consider Richard
Waltham's patch?

http://marc.theaimsgroup.com/?l=linux-kernel&m=109967237930243&w=2

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
