Return-Path: <linux-kernel-owner+w=401wt.eu-S1752581AbXACGAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbXACGAM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 01:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753623AbXACGAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 01:00:12 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:57492 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581AbXACGAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 01:00:10 -0500
Date: Wed, 3 Jan 2007 11:30:01 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Thomas Meyer <thomas@m3y3r.de>, linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: Section mismatch on current git head
Message-ID: <20070103060001.GB25433@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <458BEAA9.6010503@m3y3r.de> <20061222094710.1f29b39a.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222094710.1f29b39a.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 09:47:10AM -0800, Randy Dunlap wrote:
> On Fri, 22 Dec 2006 15:24:41 +0100 Thomas Meyer wrote:
> 
> > Hello.
> >
> > What kind of problem is this:
> > 1.) the one that should be fixed, but also can be ignored or
> > 2.) the one that have to be fixed and ignorance is a bad idea?
> >
> 
> Is this with CONFIG_RELOCATABLE=y?
> There were some patches posted to address section mismatches
> with that config option.  I suppose that they will be in the
> next -mm release (?), so this needs to be retested with
> those patches applied.
> 

Hi Randy,

I have posted some patches. But there are lots of warnings and I am
still working through the rest. Already posted patches are available
in rc2-mm1.

Any help from respective subsystem maintainers is appreciated. :-)

These problems are already present. CONFIG_RELOCATABLE=y just makes
them visible to MODPOST as relocatation information is retained in
vmlinux if CONFIG_RELOCATABLE=y.

Thanks
Vivek
