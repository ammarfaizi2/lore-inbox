Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWIAP3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWIAP3z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWIAP3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:29:55 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:36229 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751544AbWIAP3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:29:54 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <1157122479.28577.64.camel@localhost.localdomain>
References: <20060901110948.GD15684@skybase>
	 <1157122479.28577.64.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 01 Sep 2006 17:29:40 +0200
Message-Id: <1157124580.21733.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 07:54 -0700, Dave Hansen wrote:
> Are all of the un/likely()s in here really needed?

Well, no un/likely is really needed. But they do help the compiler to
generate better code. It IS unlikely that a page is discarded.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


