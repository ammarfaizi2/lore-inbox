Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbTEQTfD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 15:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTEQTfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 15:35:03 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:50731 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261789AbTEQTfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 15:35:02 -0400
Date: Sat, 17 May 2003 12:49:48 -0700
From: Andrew Morton <akpm@digeo.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: paulmck@us.ibm.com, hch@infradead.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] vm_operation to avoid pagefault/inval race
Message-Id: <20030517124948.6394ded6.akpm@digeo.com>
In-Reply-To: <200305172021.56773.phillips@arcor.de>
References: <200305172021.56773.phillips@arcor.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 May 2003 19:47:51.0599 (UTC) FILETIME=[338833F0:01C31CAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> wrote:
>
> and the only problem is, we have to change pretty well every 
>  filesystem in and out of tree.

But it's only a one-liner per fs.


