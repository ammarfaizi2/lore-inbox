Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267816AbUHERb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267816AbUHERb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267803AbUHERb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:31:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:6588 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267802AbUHERbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:31:19 -0400
Date: Thu, 5 Aug 2004 10:29:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] increase mlock limit to 32k
Message-Id: <20040805102933.0c95d12a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0408051141050.1955-100000@dhcp83-102.boston.redhat.com>
References: <20040805081445.1c4b085e.rddunlap@osdl.org>
	<Pine.LNX.4.44.0408051141050.1955-100000@dhcp83-102.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> Andrew, I'll send you an updated patch (not an incremental)
>  later today.

Well please note that the initial patch got 100% rejects because it was
against a kernel which was already using limits of PAGE_SIZE rather than
zero.  An incremental patch might be saner..

