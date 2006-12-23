Return-Path: <linux-kernel-owner+w=401wt.eu-S1753291AbWLWOT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbWLWOT0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 09:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbWLWOT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 09:19:26 -0500
Received: from ns2.suse.de ([195.135.220.15]:60736 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151AbWLWOTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 09:19:25 -0500
X-Greylist: delayed 969 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Dec 2006 09:19:25 EST
Date: Sat, 23 Dec 2006 15:02:54 +0100
From: Stefan Seyfried <seife@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       david-b@pacbell.net, gregkh@suse.de, Holger Macht <hmacht@suse.de>
Subject: Re: Changes to sysfs PM layer break userspace
Message-ID: <20061223140254.GA4974@suse.de>
References: <20061219185223.GA13256@srcf.ucam.org> <1166556889.3365.1269.camel@laptopd505.fenrus.org> <20061219194410.GA14121@srcf.ucam.org> <20061222204401.GB3960@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061222204401.GB3960@ucw.cz>
X-Operating-System: openSUSE 10.2 (i586), Kernel 2.6.18.2-34-default
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 08:44:01PM +0000, Pavel Machek wrote:
> Hi!
> 
> > > which userspace is using this btw?
> > 
> > Ubuntu uses it to disable wireless hardware under certain circumstances. 
> > I believe that Suse's powernowd uses it to power down wired ethernet 
> > hardware when it's not in use.

Powersaved had implemented this, but it was always declared an experimental
feature and AFAIK is gone since quite some time.
 
> I flamed seife for this. It was always broken for 20%-or-so of
> hardware. It is _not_ simple to fix.

It was an experimental feature in the words sense:
For experimentation. I never accepted any bugreports for that but told
the reporters to go away :-)
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
