Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVGZVLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVGZVLH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVGZVLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:11:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25014 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262087AbVGZVKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:10:34 -0400
Date: Tue, 26 Jul 2005 14:12:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: pbadari@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Memory pressure handling with iSCSI
Message-Id: <20050726141215.691379a2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0507261659250.1786@chimarrao.boston.redhat.com>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	<Pine.LNX.4.61.0507261659250.1786@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> On Tue, 26 Jul 2005, Badari Pulavarty wrote:
> 
> > After KS & OLS discussions about memory pressure, I wanted to re-do
> > iSCSI testing with "dd"s to see if we are throttling writes.  
> 
> Could you also try with shared writable mmap, to see if that
> works ok or triggers a deadlock ?
> 

That'll cause problems for sure, but we need to get `dd' right first :(
