Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbULQOPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbULQOPq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 09:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbULQOPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 09:15:46 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:42665 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261199AbULQOPl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 09:15:41 -0500
Subject: Re: [PATCH] Split bprm_apply_creds into two functions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041216182529.GC3260@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20041215200005.GB3080@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <1103145355.32732.55.camel@moss-spartans.epoch.ncsc.mil>
	 <20041216182529.GC3260@IBM-BWN8ZTBWA01.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1103292602.3437.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Dec 2004 09:10:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 13:25, Serge E. Hallyn wrote:
> Thanks.  Here is an updated patch.
> 
> -serge
> 
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Ok with me.  Chris, would it help alleviate your concerns to give the
hook a clearer name and description, e.g. bprm_post_apply_creds and move
the discussion about performing other state changes on the process like
closing descriptors from the current description of bprm_apply_creds to
it?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

