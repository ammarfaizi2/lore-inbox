Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVEMG0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVEMG0Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 02:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVEMG0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 02:26:25 -0400
Received: from fmr20.intel.com ([134.134.136.19]:30404 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262259AbVEMG0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 02:26:12 -0400
Message-ID: <42844876.8060907@linux.intel.com>
Date: Fri, 13 May 2005 01:25:58 -0500
From: James Ketrenos <jketreno@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050502
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Pavel Machek <pavel@ucw.cz>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>, jbohac@suse.cz,
       jbenc@suse.cz
Subject: Re: ipw2100: intrusive cleanups, working this time ;-)
References: <20050512225026.GA2822@elf.ucw.cz> <4283FA4D.3010208@linux.intel.com> <20050513034201.GA11817@kroah.com>
In-Reply-To: <20050513034201.GA11817@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Thu, May 12, 2005 at 07:52:29PM -0500, James Ketrenos wrote:
>  
>
>>Part of the process we have in place is to try and make sure that the
>>versions that get picked up by distros and the majority of users have a
>>'known' level of quality.  As part of that, we only want to get changes
>>pushed to -mm and eventual mainline that have gone through regression
>>testing.
>>    
>>
>
>Any chance of making those regression tests public so we can all do this
>kind of testing on any future changes that might be made to the driver?
>  
>

I believe all of our test plans are available publically.  We just put
up test runner on our bugzilla server so that we can better track which
tests have been run by users, etc.  Some tests are automated, some are
manual. 

The bugzilla site is http://bughost.org and test tracker is toward the
bottom of that page.

You can also find information at http://ipw2200.sf.net/validation.php

>Remember, once it hits mainline, lots of different people will be
>touching it for various reasons at times...
>  
>
I am hopeful that if we can get a process streamlined enough so that
regression passes can occur quickly, we will be able to keep pace w/ any
critical fixes or changes that are desired to go into mainline.

What is driving the approach is that our customers want to build
solutions with drivers that have gone through a known level of
interoperability and functionality testing. 

We ideally want to be able to say "you can either download the driver
version X from http://whatever, or any mainline kernel newer than
2.6.13+".  However we can only do that if the code that is pulled into
mainline /has/ gone through all of that testing.

The reality of the community process may require that we can only say
"version X from http://whatever or versions 2.6.{x,y,z} of the kernel"
if patches are accepted into the tree that haven't been sufficiently tested.

We want to have a process that meets the needs of the end users, the
ipw* and kernel development communities, the platform manufacturers, and
the distros.

James

>thanks,
>
>greg k-h
>  
>

