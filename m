Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272608AbTHEJl3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 05:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272609AbTHEJl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 05:41:29 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:48774 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272608AbTHEJl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 05:41:28 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 11:41:25 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: muizelaar@rogers.com, linux-kernel@vger.kernel.org,
       mru@users.sourceforge.net
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805114125.30a12916.skraw@ithnet.com>
In-Reply-To: <16175.6729.962817.135747@gargle.gargle.HOWL>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<yw1xsmohioah.fsf@users.sourceforge.net>
	<20030804152226.60204b61.skraw@ithnet.com>
	<3F2E7C63.2000203@rogers.com>
	<20030804181500.074aec51.skraw@ithnet.com>
	<16175.6729.962817.135747@gargle.gargle.HOWL>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 12:45:29 +1000
Neil Brown <neilb@cse.unsw.edu.au> wrote:

> On Monday August 4, skraw@ithnet.com wrote:
> > On Mon, 04 Aug 2003 11:31:47 -0400
> > Jeff Muizelaar <muizelaar@rogers.com> wrote:
> > 
> > > Stephan von Krawczynski wrote:
> > > 
> > > >
> > > >I guess this is not really an option if talking about hundreds or
> > > >thousands of"links", is it?
> > > >  
> > > >
> > > actually hundreds or thounds still should be ok. See...
> > 
> > Hm, and I just found out that re-exporting "mount --bind" volumes does not
> > work over nfs...
> > 
> > Is this correct, Neil?
> 
> Yes, though there is a reasonable chance that it can be made to work
> with linux-2.6.0 and nfs-utils-1.1.0 (neither of which have been
> released yet:-)

Is this a complex issue? Can you imagine a not-too-big sized patch can make it
work in 2.4? What is the basic reason it does in fact not work?

Regards,
Stephan

