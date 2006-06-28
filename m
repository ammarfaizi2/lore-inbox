Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWF1XXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWF1XXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWF1XXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:23:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30912 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751774AbWF1XXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:23:17 -0400
Date: Thu, 29 Jun 2006 09:23:05 +1000
From: Nathan Scott <nathans@sgi.com>
To: Erik Frederiksen <erik_frederiksen@pmc-sierra.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IS_ERR Threshold Value
Message-ID: <20060629092305.D1344246@wobbly.melbourne.sgi.com>
References: <20060629084128.C1344246@wobbly.melbourne.sgi.com> <1151536413.3903.1135.camel@girvin.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1151536413.3903.1135.camel@girvin.pmc-sierra.bc.ca>; from erik_frederiksen@pmc-sierra.com on Wed, Jun 28, 2006 at 05:13:33PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 05:13:33PM -0600, Erik Frederiksen wrote:
> On Wed, 2006-06-28 at 16:41, Nathan Scott wrote:
> > Hmm, I'm not sure I understand the XFS side of your report here - on
> ...
> XFS has acted correctly.  The only reason I bring it up is this is how
> the bug was brought to my attention.  

Ah, OK.  When you said this...

| it caused an alignment exception in the XFS open call when quota has
| been exceeded in the linux-mips 2.6.14 kernel.  I think that the XFS
| code has changed enough that this bug isn't in newer versions, though I
| haven't done a thorough investigation.

... I couldn't think of anything we'd changed in XFS that would have
addressed this since that kernel version.

> If there won't be any strange side effects (I don't have the experience
> to accurately comment on this), I think turning the threshold value up
> to something we can get away with in IS_ERR_VALUE() would be
> appropriate.

Seems right to me too, FWIW.

cheers.

-- 
Nathan
