Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265719AbUFSCoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265719AbUFSCoA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 22:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbUFSCoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 22:44:00 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:31438 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265719AbUFSCn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 22:43:59 -0400
Subject: Re: Atomic operation for physically moving a page
From: Dave Hansen <haveblue@us.ibm.com>
To: Ashwin Rao <ashwin_s_rao@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20040619003712.35865.qmail@web10904.mail.yahoo.com>
References: <20040619003712.35865.qmail@web10904.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1087613018.4921.29.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 19:43:38 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 17:37, Ashwin Rao wrote:
> I want to copy a page from one physical location to
> another (taking the appr. locks). To keep the
> operation of copying and updation of all ptes and
> caches atomic one way proposed by my team members was
> to sleep the processes accessing the page.

How do you make sure that no more processes begin to access the page
while you're doing your work?

BTW, look at the swap code :)

-- Dave

