Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWB0Hpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWB0Hpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 02:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWB0Hpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 02:45:35 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:59287 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751655AbWB0Hpe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 02:45:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MlwbRRz4kHYNbz6W41slIK7aUBb56NvaExNfmFPY4pOVbkaaUIF6bHJ/UfNjb1dnb6flBMZ2fUntSbo841gDHTbu7HF9uEgfCHpy9126mILHDlgUspzk3HJO+WFZPQthWVkMJtxUgMynyFRXFLROn79XAuQRN4Fk24ieMnxpmOY=
Message-ID: <4ae3c140602262345g43e71a2oea7db21c05dd5aba@mail.gmail.com>
Date: Mon, 27 Feb 2006 02:45:33 -0500
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: page cache question
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this question is dumb.

Linux uses address_space to identify pages in the page cache. An
address space is often associated with a memory object such as inode.
That seems to associate the cached page with that inode. My question
is: if a file is closed and the inode is destroyed, will the cached
page be removed from page cache immediately?  If so, does that mean
the file system has to load data from disk again if a user promptly
open and read the same file again? If not, how does linux determine
when to evict a cached page? using LRU?

Thanks in advance for your kind help!

-x
