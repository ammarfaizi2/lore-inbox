Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTFBNP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 09:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTFBNP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 09:15:58 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:37512 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262306AbTFBNP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 09:15:57 -0400
Date: Mon, 2 Jun 2003 09:29:17 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Michael Frank <mflt1@micrologica.com.hk>
cc: Andreas Hartmann <andihartmann@freenet.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap 15j for 2.4.21-rc6
In-Reply-To: <200306011926.00994.mflt1@micrologica.com.hk>
Message-ID: <Pine.LNX.4.44.0306020927070.29823-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jun 2003, Michael Frank wrote:

> Suppose rmap undoes the fixes introduced in -rc6. 

It shouldn't, unless bitkeeper made a serious merge
error (unlikely).  The rmap patch should just change
VM code, not the IO improvements.

Having said that, I'd like to thank Michael Frank for
his script that reproduces problems.  Now the problem
is reproducable I can try to fix it ...



