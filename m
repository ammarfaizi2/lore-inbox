Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265323AbUFXOqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265323AbUFXOqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 10:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264652AbUFXOqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 10:46:06 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:3040 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265323AbUFXOp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 10:45:57 -0400
Subject: Re: [PATCH][SELINUX] Extend and revise calls to secondary module
From: Serge Hallyn <serue@us.ibm.com>
To: James Morris <jmorris@redhat.com>
Cc: Valdis.Kletnieks@vt.edu, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Joshua Brindle <jbrindle@snu.edu>
In-Reply-To: <Xine.LNX.4.44.0406241003390.4970-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0406241003390.4970-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1088088518.4304.54.camel@serge.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 24 Jun 2004 09:48:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-24 at 09:04, James Morris wrote:
> Is any of this work heading into the mainline kernel?

At least for stacking, I/we hope to submit two separate patches at some
point:

1. Permit multiplexing of kernel object security fields between multiple
LSM's, like trustedbsd's does.  Without this, many modules which it
makes sense to stack, cannot be stacked.  For instance, bsdjail and (as
of recently) DigSig, and either or both of the above with SELinux.

2. A (simpler than my current) stacker LSM.

But I definately hope they're heading into the mainline kernel  :-)

-- 
=======================================================
Serge Hallyn
Security Software Engineer, IBM Linux Technology Center
serue@us.ibm.com

