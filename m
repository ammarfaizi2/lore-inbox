Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265862AbTF3Lco (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 07:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265859AbTF3Lco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 07:32:44 -0400
Received: from dp.samba.org ([66.70.73.150]:24969 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265856AbTF3Lcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 07:32:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16128.8357.34502.756929@cargo.ozlabs.ibm.com>
Date: Mon, 30 Jun 2003 21:36:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: Re: [BUG]:   problem when shutting down ppp connection since 2.5.70
In-Reply-To: <16128.7306.58928.879567@cargo.ozlabs.ibm.com>
References: <3EFFA1EA.7090502@nortelnetworks.com>
	<16128.7306.58928.879567@cargo.ozlabs.ibm.com>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> I have DSL and I could connect it up to a system running 2.5.  Maybe
> I'll go try that now...

Just tried that... no problems at all.  I connected twice, using the
rp-pppoe plugin for pppd that is in the PPP cvs tree together with the
in-kernel pppoe and pppox modules.  Both times it shut down cleanly
without putting anything in the kernel logs.

Paul.
