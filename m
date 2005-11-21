Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVKURt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVKURt6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVKURtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:49:35 -0500
Received: from citi.umich.edu ([141.211.133.111]:53644 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932419AbVKURtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:49:22 -0500
Message-ID: <438208A1.5020300@citi.umich.edu>
Date: Mon, 21 Nov 2005 12:49:21 -0500
From: Chuck Lever <cel@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Organization: Network Appliance, Inc.
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: Re: infinite loop? with mmap, nfs, pwrite, O_DIRECT
References: <20051121171332.58073.qmail@web34115.mail.mud.yahoo.com>
In-Reply-To: <20051121171332.58073.qmail@web34115.mail.mud.yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------050009030409000200000102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050009030409000200000102
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kenny Simpson wrote:
> I have a smaller test case (4 system calls, and a memset), that causes the test case to hang in an
> unkillable state*, and makes the system load consume an entire CPU.
> 
> *the process is killable if run under strace, but the system load does not drop when the strace is
> killed.
> 
> Pass this the name of a target file on an NFS mount.
> 
> (tested to fail on 2.6.15-rc1).

kenny-

i'm assuming that because you copied trond, this is only reproducible on 
NFS.  have you tried this test on other local and remote file system types?

--------------050009030409000200000102
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------050009030409000200000102--
