Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266493AbUGUUZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266493AbUGUUZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 16:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266625AbUGUUZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 16:25:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:44686 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266493AbUGUUZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 16:25:37 -0400
Subject: Re: Inode question
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: sankarshana rao <san_wipro@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040721183951.98507.qmail@web50906.mail.yahoo.com>
References: <20040721183951.98507.qmail@web50906.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1090441528.17486.25.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 21 Jul 2004 15:25:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 13:39, sankarshana rao wrote:
> Hi,
> I want to call namei() function in order to derive an
> inode from a path name. Can I do this inside a kernel
> module???

>From a kernel module, you should probably call path_lookup().

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

