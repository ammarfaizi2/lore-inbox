Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266489AbUBLPlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 10:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266493AbUBLPlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 10:41:23 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:50084 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266489AbUBLPlV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 10:41:21 -0500
Subject: Re: JFS default behavior (was: UTF-8 in file systems?
	xfs/extfs/etc.)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: Andy Isaacson <adi@hexapodia.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200402121526.i1CFQXL7018236@turing-police.cc.vt.edu>
References: <20040209115852.GB877@schottelius.org>
	 <slrn-0.9.7.4-32556-23428-200402111736-tc@hexane.ssi.swin.edu.au>
	 <1076517309.21961.169.camel@shaggy.austin.ibm.com>
	 <20040212004532.GB29952@hexapodia.org>
	 <200402121526.i1CFQXL7018236@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1076600469.16375.7.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Feb 2004 09:41:09 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-12 at 09:26, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 11 Feb 2004 18:45:32 CST, Andy Isaacson said:
> Now, over the last 15 years I've tripped over a number of *userspace*
> things that did really stupid things when handed non-ASCII filenames,
> but that's a different issue...

That's the problem that OS/2 addressed.  In OS/2 each application would
see the correct charset for its locale, no matter what the locale of the
application that created the file was.  In Linux, the file system simply
doesn't have the information needed to do this, so it was a mistake to
try to imitate it.
-- 
David Kleikamp
IBM Linux Technology Center

