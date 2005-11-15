Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbVKORBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVKORBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVKORBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:01:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:12174 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964954AbVKORBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:01:16 -0500
Date: Tue, 15 Nov 2005 08:47:08 -0800
From: Greg KH <greg@kroah.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051115164708.GA12807@kroah.com>
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com> <20051115010155.GA3792@IBM-BWN8ZTBWAO1> <20051114175140.06c5493a.pj@sgi.com> <20051115022931.GB6343@sergelap.austin.ibm.com> <20051114193715.1dd80786.pj@sgi.com> <20051115051501.GA3252@IBM-BWN8ZTBWAO1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115051501.GA3252@IBM-BWN8ZTBWAO1>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 11:15:01PM -0600, Serge E. Hallyn wrote:
> Quoting Paul Jackson (pj@sgi.com):
> > Serge wrote:
> > > the vserver model
> > 
> > What's that?
> 
> :)  Well a vserver pretends to be a full system of its own, though you
> can have lots of vservers on one machine.  Processes in each virtual
> server see only other processes in the same vserver.  However in
> vserver the pids they see are the real kernel pids - except for one
> process per vserver which can be the fakeinit.  Other processes in the
> same vserver see it as pid 1, but to the kernel it is still known by
> its real pid.

Why not just use Xen?  It can handle process migration from one virtual
machine to another just fine.

thanks,

greg k-h
