Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbUKPTXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbUKPTXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbUKPTVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:21:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:1159 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262107AbUKPTUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:20:50 -0500
Date: Tue, 16 Nov 2004 11:20:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Making compound pages mandatory
Message-Id: <20041116112022.67be2377.akpm@osdl.org>
In-Reply-To: <2315.1100630906@redhat.com>
References: <2315.1100630906@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> 
> Hi Linus,
> 
> Do you have any objection to compound pages being made mandatory, even without
> HUGETLB support?
> 

Andrea wants to do that, purely from a code coverage point of view.  But it
does add a little extra overhead.

For what reason do you propose this?
