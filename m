Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263324AbUJ2NcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUJ2NcH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbUJ2NcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:32:07 -0400
Received: from siaag1aa.compuserve.com ([149.174.40.3]:59369 "EHLO
	siaag1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S263323AbUJ2Nbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:31:41 -0400
Date: Fri, 29 Oct 2004 09:27:18 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC] Linux 2.6.9.1-pre1 contents
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200410290931_MC3-1-8D6D-E71B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 at 00:46:32 -0700 Chris Wedgwood wrote:

> On Thu, Oct 28, 2004 at 10:02:58PM -0400, Chuck Ebbert wrote:
>
>> I have been working on a set of patches that I currently call Linux
>> 2.6.9.1.
>
> check -mm kernels or http://linux.bkbits.net/linux-2.5/


  You mean like this?


[me@d4 linux-2.6]$ bk pull -R
Pull http://linux.bkbits.net:8080/linux-2.6
  -> file://home/me/bk-repo/linux-2.6
Nothing to pull.


[me@d4 linux-2.6]$ bk prs -r+ drivers/cdrom/cdrom.c
======== drivers/cdrom/cdrom.c 1.78 ========
D 1.78 04/10/28 00:39:59-07:00 petero2@telia.com[torvalds] 84 83 2/0/3397
P drivers/cdrom/cdrom.c
C Fix incorrect Mt Rainier detection
------------------------------------------------


  I merged the identical change to cdrom.c to my changeset on 04/10/27
at 21:20 -0500, i.e. before Linus did.

  However, I only merge bugfixes, not new features, so LVM still works
in my tree.  :)


--Chuck Ebbert  29-Oct-04  09:27:11
