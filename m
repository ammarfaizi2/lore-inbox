Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVCCUnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVCCUnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVCCUlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:41:06 -0500
Received: from fire.osdl.org ([65.172.181.4]:1944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262565AbVCCUfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:35:09 -0500
Date: Thu, 3 Mar 2005 12:33:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information
Message-Id: <20050303123356.0255f448.akpm@osdl.org>
In-Reply-To: <13844.1109857330@redhat.com>
References: <20050302143934.30d191d7.akpm@osdl.org>
	<20050302090734.5a9895a3.akpm@osdl.org>
	<9420.1109778627@redhat.com>
	<31789.1109799287@redhat.com>
	<20050302135146.2248c7e5.akpm@osdl.org>
	<Pine.LNX.4.58.0503021423420.25732@ppc970.osdl.org>
	<13844.1109857330@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Yup.  In this application the fields are initialised once (usually at
> > compile time) and are never modified.
> 
> That's not exactly so. The block layer appears to modify them. See
> blk_queue_make_request() in ll_rw_blk.c.
> 

That's a (strangely named) once-off setup thing.
