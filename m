Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTIOR7T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 13:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbTIOR7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 13:59:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:41125 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261190AbTIOR7S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 13:59:18 -0400
Subject: Re: test5 and JFS on /: problems, anyone?
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200309131917.11731.cova@ferrara.linux.it>
References: <200309131917.11731.cova@ferrara.linux.it>
Content-Type: text/plain
Message-Id: <1063648747.16443.178.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 15 Sep 2003 12:59:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-13 at 12:17, Fabio Coatti wrote:
> I'm using JFS on / partition on a couple of machines and when I've installed 
> 2.6.0-test5 I've got fs corruption on both. 

I'm also getting corruption with JFS on -test5.  It looks new meta-data
is okay in memory, but is getting corrupted writing it to disk.  I am
investigating.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

