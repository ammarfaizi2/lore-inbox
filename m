Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUD0Sch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUD0Sch (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUD0Sch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:32:37 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:55812 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S264260AbUD0Scf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:32:35 -0400
Date: Tue, 27 Apr 2004 14:32:28 -0400
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Return more useful error number when acls are too large
Message-ID: <20040427183228.GF2086@fieldses.org>
References: <1082973939.3295.16.camel@winden.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082973939.3295.16.camel@winden.suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 12:27:58PM +0200, Andreas Gruenbacher wrote:
> could you please add this to mainline? Getting EINVAL when an acl
> becomes too large is quite confusing.

On my system, at least, "man acl_set_file" does explicitly say that
EINVAL is returned in this case.  Whether that should be considered a
bug in the documentation or the code I don't know....

--Bruce Fields
