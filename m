Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263935AbUDQAEK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 20:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263950AbUDQAEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 20:04:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47241 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263935AbUDQAEH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 20:04:07 -0400
Message-ID: <40807466.1020701@pobox.com>
Date: Fri, 16 Apr 2004 20:03:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Greg KH <greg@kroah.com>, Maneesh Soni <maneesh@in.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040415220232.GC23039@kroah.com> <20040416152448.GF24997@parcelfarce.linux.theplanet.co.uk> <20040416223732.GC21701@kroah.com> <20040416234601.GL24997@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040416234601.GL24997@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Fri, Apr 16, 2004 at 03:37:32PM -0700, Greg KH wrote:
> 
> 
>>Since when did we ever assume that renaming a kobject would rename the
>>symlinks that might point to it?  Renaming kobjects are a hack that way,
>>if you use them, you need to be aware of this limitation.
> 
> 
> Since we assume that these symlinks actually reflect some relationship
> between the objects and are really needed for something.  If they are
> not - why the hell do we keep them at all?


I was wondering the same thing :)

Ideally one would think that userland can deduce relationships by 
looking at the attribute information sysfs already provides -- and if 
not, it's just one more bit of info to export via sysfs.

	Jeff



