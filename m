Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTKQV0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbTKQV0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:26:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:51647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261500AbTKQV0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:26:04 -0500
Date: Mon, 17 Nov 2003 13:25:55 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@redhat.com>, sds@epoch.ncsc.mil, aviro@redhat.com,
       linux-kernel@vger.kernel.org, russell@coker.com.au
Subject: Re: [PATCH][RFC] Remove CLONE_FILES from init kernel thread creation
Message-ID: <20031117132555.A24403@osdlab.pdx.osdl.net>
References: <Xine.LNX.4.44.0311171439590.2731-100000@thoron.boston.redhat.com> <20031117124954.6fa4e366.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031117124954.6fa4e366.akpm@osdl.org>; from akpm@osdl.org on Mon, Nov 17, 2003 at 12:49:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> 
> I wonder why call_usermodehelper() uses CLONE_FILES...

Looks like 2.5 used to actually close all fd's before exec'ing the
usermodehelper.  I wonder if it's just a result of Rusty's consolidation
and using CLONE_KERNEL?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
