Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbVKOTlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbVKOTlb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbVKOTlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:41:31 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:58855 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964970AbVKOTla
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:41:30 -0500
Date: Tue, 15 Nov 2005 13:41:28 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Ray Bryant <raybry@mpdtxmail.amd.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051115194127.GB17287@sergelap.austin.ibm.com>
References: <20051114212341.724084000@sergelap> <200511151321.08860.raybry@mpdtxmail.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511151321.08860.raybry@mpdtxmail.amd.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ray Bryant (raybry@mpdtxmail.amd.com):
> On Monday 14 November 2005 15:23, Serge E. Hallyn wrote:
> > --
> >
> > I'm part of a project implementing checkpoint/restart processes.
> > After a process or group of processes is checkpointed, killed, and
> > restarted, the changing of pids could confuse them.  There are many
> > other such issues, but we wanted to start with pids.
> >
> 
> I've read through the rest of this thread, but it seems to me that the real 
> problems are in the basic assumptions you are making that are driving the 
> rest of this effort and perhaps we should be examining those assumptions 
> instead of your patch.   

Ok.

> For example, from what I've read (particularly Hubertus's post that the pid 
> could be in a register), I'm inferring that what you want to do is to be able 
> to checkpoint/restart an arbitrary process at an arbitrary time and without 
> any special support for checkpoint/restart in that process.   

Yes.

> Also (c. f. Dave Hansen's post on the number of Xen virtual machines 
> required),  you appear to think that the number of processes on the system 
> for which checkpoint/restart should be enabled is large (more or less the 
> same as the number of processes on the system).

Right.

> Am I reading this correctly?

As far as I can see, yes.

-serge
