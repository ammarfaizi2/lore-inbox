Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVC1Hpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVC1Hpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 02:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVC1Hpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 02:45:46 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:23466 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261261AbVC1Hpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 02:45:38 -0500
Date: Mon, 28 Mar 2005 02:45:30 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
To: linux-kernel@vger.kernel.org
Cc: bugfixer@lists.ru
Subject: Re: 2.6.12-rc1-mm3: class_simple API
Message-ID: <20050328074530.GD11458@mail>
Mail-Followup-To: linux-kernel@vger.kernel.org, bugfixer@lists.ru
References: <20050327180431.GA4327@nikolas.hn.org> <20050327181717.GC14502@kroah.com> <20050327183927.GA4535@nikolas.hn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050327183927.GA4535@nikolas.hn.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/05 01:39:27PM -0500, Nick Orlov wrote:
> On Sun, Mar 27, 2005 at 10:17:17AM -0800, Greg KH wrote:
> > On Sun, Mar 27, 2005 at 01:04:31PM -0500, Nick Orlov wrote:
> > > 
> > >  - Whether the changes like the one above are "the right thing to do" ?
> > 
> > Yes.
> 
> Questionable.
> 
> > 
> > >  - What's the best way to deal with this particular issue ?
> > 
> > Change the code to not use these functions.
> 
> In other words "forget about nvidia <-> udev interaction" ?
> I do not think it is acceptable.
> 
> > Look at the vmware code for examples of how to do this.
> 
> Is there a place where I can download the code example without
> registering / paying license fee ?

http://ftp.cvut.cz/vmware/

The file vmware-any-any-update*.tar.gz contains the source to all of the
VMWare kernel modules. IIRC I found the URL in the VMWare newsgroups and
they're maintained unofficially by a VMWare employee.

> 
> P.S. Please CC me, I'm not subscribed to the list.
> 
> -- 
> With best wishes,
> 	Nick Orlov.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
