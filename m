Return-Path: <linux-kernel-owner+w=401wt.eu-S1422691AbXAETvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbXAETvE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 14:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422703AbXAETvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 14:51:04 -0500
Received: from xenotime.net ([66.160.160.81]:46463 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422691AbXAETvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 14:51:03 -0500
Date: Fri, 5 Jan 2007 11:51:09 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Shlomi Fish <shlomif@iglu.org.il>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] qconf Search Dialog
Message-Id: <20070105115109.4c0305da.rdunlap@xenotime.net>
In-Reply-To: <200701051244.14029.shlomif@iglu.org.il>
References: <200701031954.36440.shlomif@iglu.org.il>
	<200701032201.28384.shlomif@iglu.org.il>
	<20070103210535.GA31780@uranus.ravnborg.org>
	<200701051244.14029.shlomif@iglu.org.il>
Organization: YPO4
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007 12:44:13 +0200 Shlomi Fish wrote:

> On Wednesday 03 January 2007 23:05, Sam Ravnborg wrote:
> > On Wed, Jan 03, 2007 at 10:01:28PM +0200, Shlomi Fish wrote:
> > > Interesting. I didn't notice this search dialog before because its menu
> > > item was placed in the "File" menu, which is the wrong place for a find
> > > command (Which should be in an "Edit" or "Search" menu). I believe others
> > > have missed it as well. Also, it is possible it wasn't available when I
> > > wrote the preliminary version of the patch back in March.
> > >
> > > Aside from that my search dialog has some advantages:
> > >
> > > 1. Full text search - if you search for "available" in File->Search you
> > > won't find anything. Searching for it in Edit->Find will find many
> > > things. I think File->Search only searches using the identifiers or at
> > > most also the title.
> > >
> > > 2. Regular expression search.
> > >
> > > 3. Displaying the results in a tree, with their context.
> > >
> > > All that said, I don't mind merging my modifications into the existing
> > > code, or replacing it entirely.
> >
> > Please merge the best of the existing and the new search dialog.
> >
> 
> OK.
> 
> > I would prefer it as separate smaller steps.
> > So one patch where you move the dialog and another where you improve
> > the search dialog.
> >
> 
> Move the dialog from where, to where, and in what respect?

>From where it currently is in mainline (File/Find) to where your
patch puts it (Edit/Find).  And then "fix" the Find function in a
separate patch.

---
~Randy
