Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUBUDUb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 22:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUBUDUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 22:20:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7886 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261497AbUBUDSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 22:18:36 -0500
From: Daniel Phillips <phillips@arcor.de>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: GFS requirements (was: Non-GPL export of invalidate_mmap_range)
Date: Fri, 20 Feb 2004 22:16:09 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <20040216190927.GA2969@us.ibm.com> <200402201715.34315.phillips@arcor.de> <20040220235602.GD6280@marowsky-bree.de>
In-Reply-To: <20040220235602.GD6280@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402202216.09908.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 February 2004 18:56, Lars Marowsky-Bree wrote:
> Surely, such a GFS needs a cluster infrastructure - membership,
> messaging, DLM - in the kernel.
>
> Can you or anyone else from Sistina/RHAT clarify on the details of
> this?

Hi Lars,

I presume you meant "DFS".  I can't comment on the details of the plan for GFS 
just now, however consider OpenGFS: yes, it needs and has a cluster 
infrastructure.  The kernel does not dictate anything about that 
infrastructure.  Each DFS is free to implement its own infrastructure, 
possibly involving kernel extensions.

Regards,

Regards

