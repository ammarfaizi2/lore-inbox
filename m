Return-Path: <linux-kernel-owner+w=401wt.eu-S932124AbXACVFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbXACVFl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbXACVFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:05:41 -0500
Received: from pasmtpb.tele.dk ([80.160.77.98]:40151 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932124AbXACVFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:05:40 -0500
Date: Wed, 3 Jan 2007 22:05:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Shlomi Fish <shlomif@iglu.org.il>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] qconf Search Dialog
Message-ID: <20070103210535.GA31780@uranus.ravnborg.org>
References: <200701031954.36440.shlomif@iglu.org.il> <20070103095422.f89a88e5.randy.dunlap@oracle.com> <200701032201.28384.shlomif@iglu.org.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701032201.28384.shlomif@iglu.org.il>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 10:01:28PM +0200, Shlomi Fish wrote:
> 
> Interesting. I didn't notice this search dialog before because its menu item 
> was placed in the "File" menu, which is the wrong place for a find command 
> (Which should be in an "Edit" or "Search" menu). I believe others have missed 
> it as well. Also, it is possible it wasn't available when I wrote the 
> preliminary version of the patch back in March.
> 
> Aside from that my search dialog has some advantages:
> 
> 1. Full text search - if you search for "available" in File->Search you won't 
> find anything. Searching for it in Edit->Find will find many things. I think 
> File->Search only searches using the identifiers or at most also the title.
> 
> 2. Regular expression search.
> 
> 3. Displaying the results in a tree, with their context.
> 
> All that said, I don't mind merging my modifications into the existing code, 
> or replacing it entirely.
Please merge the best of the existing and the new search dialog.

I would prefer it as separate smaller steps.
So one patch where you move the dialog and another where you improve
the search dialog.

	Sam
