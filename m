Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWEIF5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWEIF5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 01:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWEIF5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 01:57:49 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:23260 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751409AbWEIF5s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 01:57:48 -0400
Subject: Re: GPL-only symbols issue
From: Ram Pai <linuxram@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Jan Beulich <jbeulich@novell.com>, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060509042500.GA4226@kroah.com>
References: <445F0B6F.76E4.0078.0@novell.com>
	 <20060509042500.GA4226@kroah.com>
Content-Type: text/plain
Organization: IBM 
Date: Mon, 08 May 2006 22:57:18 -0700
Message-Id: <1147154238.7203.62.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 21:25 -0700, Greg KH wrote:
> On Mon, May 08, 2006 at 09:12:15AM +0200, Jan Beulich wrote:
> > Sam,
> > 
> > would it seem reasonable a request to detect imports of GPL-only
> > symbols by non-GPL modules also at build time rather than only at run
> > time, and at least warn about such?
> 
> Ram has some tools that might catch this kind of thing.  He's posted his
> scripts to lkml in the past, try looking in the archives.

The patches are at

http://sudhaa.com/~ram/misc/kernelpatch

The patch of interest for you would be modpost.patch
I have a script and some code that can poke into a given .ko file and
warn against symbols that don't match what the kernel exports. 

I can post that code if there is interest in that functionality,
RP

> 
> thanks,

> greg k-h

