Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVADWJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVADWJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVADWIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:08:42 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:58345 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262383AbVADWEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:04:32 -0500
Subject: Re: [PATCH] properly split capset_check+capset_set
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050104162745.GA400@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20050104162745.GA400@IBM-BWN8ZTBWA01.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1104875716.20724.158.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 04 Jan 2005 16:55:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 11:27, Serge E. Hallyn wrote:
> The attached patch removes checks from kernel/capability.c which are
> redundant with cap_capset_check() code, and moves the capset_check()
> calls to immediately before the capset_set() calls.  This allows
> capset_check() to accurately check the setter's permission to set caps
> on the target.  Please apply.
> 
> thanks,
> -serge
> 
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

