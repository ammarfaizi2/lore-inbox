Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWDUXzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWDUXzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 19:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWDUXzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 19:55:22 -0400
Received: from ozlabs.org ([203.10.76.45]:54489 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750773AbWDUXzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 19:55:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17481.28892.506618.865014@cargo.ozlabs.ibm.com>
Date: Sat, 22 Apr 2006 09:55:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@namei.org>, dwalker@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
In-Reply-To: <20060421015412.49a554fa.akpm@osdl.org>
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com>
	<Pine.LNX.4.64.0604210322110.21429@d.namei>
	<20060421015412.49a554fa.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Yes, kfree(NULL) is supposed to be uncommon.  If someone's doing it a lot
> then we should fix up the callers.

Well, we'd have to start by fixing up the janitors that run around
taking out the if statements in the callers.  :)

Paul.
