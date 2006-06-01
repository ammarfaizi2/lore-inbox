Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965307AbWFAVGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965307AbWFAVGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965306AbWFAVGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:06:25 -0400
Received: from [212.33.162.190] ([212.33.162.190]:1028 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S965307AbWFAVGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:06:24 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
Date: Fri, 2 Jun 2006 00:03:51 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200606020003.51504.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Thu, 2006-06-01 at 14:04 +0530, Balbir Singh wrote:
> > Kirill Korotaev wrote:
> > >> Do you have any documented requirements for container resource
> > >> management?
> > >> Is there a minimum list of features and nice to have features for
> > >> containers
> > >> as far as resource management is concerned?
> > >
> > > Sure! You can check OpenVZ project (http://openvz.org) for example of
> > > required resource management. BTW, I must agree with other people here
> > > who noticed that per-process resource management is really useless and
> > > hard to use :(
>
> I totally agree.
>
> > I'll take a look at the references. I agree with you that it will be
> > useful to have resource management for a group of tasks.

For Resource Management to be useful it must depend on Resource Control.  
Resource Control depends on per-process accounting.  Per-process accounting, 
when abstracted sufficiently, may enable higher level routines, preferrably 
in userland, to extend functionality at will.  All efforts should really go 
into the successful abstraction of per-process accounting.

Thanks!

--
Al

