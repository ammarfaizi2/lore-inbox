Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWFPEAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWFPEAj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 00:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWFPEAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 00:00:39 -0400
Received: from ozlabs.org ([203.10.76.45]:21888 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751027AbWFPEAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 00:00:39 -0400
Subject: Re: [PATCH] kthread: convert stop_machine into a kthread
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060616030432.GA18037@sergelap.austin.ibm.com>
References: <17553.56625.612931.136018@cargo.ozlabs.ibm.com>
	 <1150419895.10290.9.camel@localhost.localdomain>
	 <20060616030432.GA18037@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 16 Jun 2006 14:00:29 +1000
Message-Id: <1150430429.10290.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-15 at 22:04 -0500, Serge E. Hallyn wrote:
> Quoting Rusty Russell (rusty@rustcorp.com.au):
> > Seems like change for change's sake, to me, *and* it added more code
> > than it removed.
> 
> So if kernel_thread is really going to be removed, how else should this
> be done?  Just clone?

Sorry, is kernel_thread going to be removed, or just not exported to
modules?  What's kthread going to use?

Confused,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

