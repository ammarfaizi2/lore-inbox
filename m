Return-Path: <linux-kernel-owner+w=401wt.eu-S1161052AbXAEKsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbXAEKsy (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 05:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbXAEKsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 05:48:54 -0500
Received: from sa5.bezeqint.net ([192.115.104.19]:50167 "EHLO sa5.bezeqint.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161052AbXAEKsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 05:48:53 -0500
From: Shlomi Fish <shlomif@iglu.org.il>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2.6.20-rc3] qconf Search Dialog
Date: Fri, 5 Jan 2007 12:44:13 +0200
User-Agent: KMail/1.9.4
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org
References: <200701031954.36440.shlomif@iglu.org.il> <200701032201.28384.shlomif@iglu.org.il> <20070103210535.GA31780@uranus.ravnborg.org>
In-Reply-To: <20070103210535.GA31780@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701051244.14029.shlomif@iglu.org.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 January 2007 23:05, Sam Ravnborg wrote:
> On Wed, Jan 03, 2007 at 10:01:28PM +0200, Shlomi Fish wrote:
> > Interesting. I didn't notice this search dialog before because its menu
> > item was placed in the "File" menu, which is the wrong place for a find
> > command (Which should be in an "Edit" or "Search" menu). I believe others
> > have missed it as well. Also, it is possible it wasn't available when I
> > wrote the preliminary version of the patch back in March.
> >
> > Aside from that my search dialog has some advantages:
> >
> > 1. Full text search - if you search for "available" in File->Search you
> > won't find anything. Searching for it in Edit->Find will find many
> > things. I think File->Search only searches using the identifiers or at
> > most also the title.
> >
> > 2. Regular expression search.
> >
> > 3. Displaying the results in a tree, with their context.
> >
> > All that said, I don't mind merging my modifications into the existing
> > code, or replacing it entirely.
>
> Please merge the best of the existing and the new search dialog.
>

OK.

> I would prefer it as separate smaller steps.
> So one patch where you move the dialog and another where you improve
> the search dialog.
>

Move the dialog from where, to where, and in what respect?

Regards,

	Shlomi Fish

---------------------------------------------------------------------
Shlomi Fish      shlomif@iglu.org.il
Homepage:        http://www.shlomifish.org/

Chuck Norris wrote a complete Perl 6 implementation in a day but then
destroyed all evidence with his bare hands, so no one will know his secrets.
