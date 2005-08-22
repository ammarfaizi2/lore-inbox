Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVHWAnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVHWAnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 20:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVHWAnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 20:43:11 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:30627 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932358AbVHWAnK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 20:43:10 -0400
Date: Mon, 22 Aug 2005 14:57:48 -0500
From: serue@us.ibm.com
To: Chris Wright <chrisw@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, serue@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, linux-security-module@wirex.com,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH -mm 3/3] [LSM] Stacking support for inode_init_security
Message-ID: <20050822195748.GA9372@sergelap.austin.ibm.com>
References: <20050822080401.GA26125@sergelap.austin.ibm.com> <20050822082028.GB25390@sergelap.austin.ibm.com> <20050822165209.GB5511@sergelap.austin.ibm.com> <20050822231111.GM9927@stusta.de> <20050822231419.GD7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822231419.GD7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wright (chrisw@osdl.org):
> * Adrian Bunk (bunk@stusta.de) wrote:
> > You want to build these modules always and always modular?
> > 
> > No matter whether the security subsystem is built modular or static?
> > 
> > No matter whether the user has enabled or completely disabled the 
> > security subsystem?
> 
> The modules are just for testing, and shouldn't be added at all.

Right, in no way should the testing modules be upstreamed :)

thanks,
-serge
