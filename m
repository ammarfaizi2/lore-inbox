Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266584AbUBDVrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUBDVrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:47:07 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:45563 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266584AbUBDVrC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:47:02 -0500
Subject: Re: [Bug 2013] New: Oops from create_dir (sysfs)
From: John Rose <johnrose@austin.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040204212253.GA3897@kroah.com>
References: <1075926442.3026.37.camel@verve>
	 <20040204204811.GA3992@us.ibm.com> <1075928072.3026.47.camel@verve>
	 <20040204212253.GA3897@kroah.com>
Content-Type: text/plain
Message-Id: <1075931022.3026.63.camel@verve>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 04 Feb 2004 15:43:42 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<crickets chirp>.  That's one way to shut me up :)

In all seriousness, how much of a performance problem would be posed by
throwing a kset_find_obj() check somewhere in the beginning of
kobject_add()? 

Thanks-
John

On Wed, 2004-02-04 at 15:22, Greg KH wrote:
> On Wed, Feb 04, 2004 at 02:54:32PM -0600, John Rose wrote:
> > > The kobject code quickly pointed out the flaw in your code.  
> > 
> > That it did, but an "already exists" return code from kobject_add would
> > have pointed it out more quickly :)
> 
> Patches are always gladly accepted :)
> 
> thanks,
> 
> greg k-h

