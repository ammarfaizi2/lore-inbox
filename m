Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUJGGSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUJGGSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 02:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUJGGSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 02:18:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50101 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267306AbUJGGSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 02:18:53 -0400
Date: Thu, 7 Oct 2004 02:18:42 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, <chrisw@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/3] lsm: add bsdjail module
In-Reply-To: <20041007040859.GA17774@escher.cs.wm.edu>
Message-ID: <Xine.LNX.4.44.0410070216130.2191-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Serge E. Hallyn wrote:

> Because it gives Linux a functionality like FreeBSD's jail and Solaris'
> zones in an unobtrusive manner, without impacting users who don't wish
> to use it  (except for the extra security_task_lookup function calls).

Yes, as an LSM module, it can be configured out.  I think it's a good use
of the LSM framework, and may be useful for people migrating to Linux from
legacy Solaris and FreeBSD.


- James
-- 
James Morris
<jmorris@redhat.com>


