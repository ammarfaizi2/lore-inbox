Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270751AbTG0Lwb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 07:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270753AbTG0Lwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 07:52:31 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:32734 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S270751AbTG0Lwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 07:52:30 -0400
Date: Sun, 27 Jul 2003 14:07:40 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] sanitize power management config menus
Message-ID: <20030727120740.GA24002@louise.pinerecords.com>
References: <20030726200213.GD16160@louise.pinerecords.com> <20030726194651.5e3f00bb.rddunlap@osdl.org> <20030727025647.GB17724@louise.pinerecords.com> <20030726204623.47b08882.rddunlap@osdl.org> <20030727111340.GB1957@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030727111340.GB1957@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	  This creates an image which is saved in your active swap space. On
> > +	  the next boot, pass the 'resume=/path/to/your/swap/file' option and
> 
> Swap *files* are no longer supported. Swap partitions work.

Right.

> >  	  Right now you may boot without resuming and then later resume but
> > -	  in meantime you cannot use those swap partitions/files which were
> > +	  in the meantime you cannot use those swap partitions/files which were
> >  	  involved in suspending. Also in this case there is a risk that buffers
> >  	  on disk won't match with saved ones.
> 
> I guess we do not want to teach people doing this.

Right.

> > -	  SMP is supported __as-is''. There's a code for it but doesn't work.
> > -	  There have been problems reported relating SCSI.
> > +	  SMP is supported __as-is''. There's code for it but doesn't work.
> > +	  There have been problems reported relating to SCSI.
> 
> SMP is not supported. Kill the note about SCSI.

Ok.

> > -	  This option is about getting stable. However there is still some
> > +	  This option is close to getting stable. However there is still some
> >  	  absence of features.
> 
> Kill this. Saying (EXPERIMENTAL) should be enough.

Agreed.

I'll be sending a revised combined patch to clean up the power
management menu in a minute, will CC.

-- 
Tomas Szepe <szepe@pinerecords.com>
