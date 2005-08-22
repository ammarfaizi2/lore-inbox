Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVHVXRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVHVXRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVHVXRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:17:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932374AbVHVXRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:17:43 -0400
Date: Mon, 22 Aug 2005 16:14:19 -0700
From: Chris Wright <chrisw@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@wirex.com, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH -mm 3/3] [LSM] Stacking support for inode_init_security
Message-ID: <20050822231419.GD7762@shell0.pdx.osdl.net>
References: <20050822080401.GA26125@sergelap.austin.ibm.com> <20050822082028.GB25390@sergelap.austin.ibm.com> <20050822165209.GB5511@sergelap.austin.ibm.com> <20050822231111.GM9927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822231111.GM9927@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@stusta.de) wrote:
> You want to build these modules always and always modular?
> 
> No matter whether the security subsystem is built modular or static?
> 
> No matter whether the user has enabled or completely disabled the 
> security subsystem?

The modules are just for testing, and shouldn't be added at all.
