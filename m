Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbTDGR1S (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 13:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263575AbTDGR1S (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 13:27:18 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:13329
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263570AbTDGR1R 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 13:27:17 -0400
Subject: Re: Same syscall is defined to different numbers on 3 different
	archs(was Re: Makefile issue)
From: Robert Love <rml@tech9.net>
To: Robert Williamson <robbiew@us.ibm.com>
Cc: Aniruddha M Marathe <aniruddha.marathe@wipro.com>,
       linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
In-Reply-To: <OF51DE965A.FDCB6DBE-ON85256D01.005201B1-86256D01.005610CF@pok.ibm.com>
References: <OF51DE965A.FDCB6DBE-ON85256D01.005201B1-86256D01.005610CF@pok.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049737135.717.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 07 Apr 2003 13:38:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 11:39, Robert Williamson wrote:

> However, I looked at the kernel, and it seems that there is a
> BUG in the code....there are different numbers assigned to the
> timer system calls for different archs:

Syscall numbers are supposed to be unique to each architecture... they
are per-arch.

	Robert Love

