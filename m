Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263208AbTDCB3J>; Wed, 2 Apr 2003 20:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbTDCB3J>; Wed, 2 Apr 2003 20:29:09 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:59666
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263208AbTDCB3I>; Wed, 2 Apr 2003 20:29:08 -0500
Subject: Re: back-trace on mounting ide cd-rom
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030402154500.3e6b9a62.akpm@digeo.com>
References: <1049326318.2872.36.camel@localhost>
	 <20030402154500.3e6b9a62.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049334036.1196.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 02 Apr 2003 20:40:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-02 at 18:45, Andrew Morton wrote:

> ah, my new debug code is buggy.  It is legal to wait upon a zero-ref buffer
> if that buffer's page is locked.

That fixed it (or it is not reproducing itself).

Thanks, Andrew.  Glad to be of service.

	Robert Love

