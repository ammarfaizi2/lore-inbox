Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbVHTDW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbVHTDW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 23:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbVHTDW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 23:22:27 -0400
Received: from smtp.istop.com ([66.11.167.126]:13460 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932648AbVHTDW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 23:22:26 -0400
From: Daniel Phillips <phillips@istop.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Permissions don't stick on ConfigFS attributes
Date: Sat, 20 Aug 2005 13:23:29 +1000
User-Agent: KMail/1.7.2
Cc: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org
References: <200508201050.51982.phillips@istop.com> <20050820030117.GA775@kroah.com>
In-Reply-To: <20050820030117.GA775@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508201323.29355.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 August 2005 13:01, Greg KH wrote:
> On Sat, Aug 20, 2005 at 10:50:51AM +1000, Daniel Phillips wrote:
> > So: Integrate with sysfs.
>
> No, don't.  Do you think that Joel would not have already worked with
> the sysfs people prior to submitting this?  No, he did, and we all
> agreed that it should be kept separate.

Would you care to recap the reasoning, please?

> > Terminology skew.  It is a very bad idea to call your configfs files
> > "attributes".
>
> That's what sysfs calls its files.  They used the same naming scheme
> there.  This is nothing that a user ever cares about or sees.

It's wrrrrronnnggg.  The best you can defend this with is "it's entrenched".

> > Memory requirements.  ConfigFS pins way too much kernel memory for inodes
> > and dentries.
>
> configfs is not going to have that many nodes at all in memory (compared
> to sysfs), so I don't think this is a big problem.

The current bloat is unconscionable, for the amount of data that is carried.  
Are you arguing against fixing it?  And what makes you think configfs will 
never have lots of nodes?

Regards,

Daniel
