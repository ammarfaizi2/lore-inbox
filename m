Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTJCUOd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 16:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbTJCUOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 16:14:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:29353 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261168AbTJCUOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 16:14:32 -0400
Date: Fri, 3 Oct 2003 13:13:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: hannal@us.ibm.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Minutes from 10/1 LSE Call
Message-Id: <20031003131329.61fc0783.akpm@osdl.org>
In-Reply-To: <3F7DCEED.9080801@austin.ibm.com>
References: <37940000.1065035945@w-hlinder>
	<20031001162916.5fc2241b.akpm@osdl.org>
	<3F7C7AA9.2050404@austin.ibm.com>
	<20031002123618.7947d232.akpm@osdl.org>
	<3F7DCEED.9080801@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Pratt <slpratt@austin.ibm.com> wrote:
>
> Get the latest rawread from 
> http://www-124.ibm.com/developerworks/opensource/linuxperf/rawread/rawread.html

Sigh, I was afraid of that.  My previous outings with rawread have not been
happy.  Maybe your detailed descriptions will help.

> But as long as I have your attention, there is one other thing about 
> these runs which bothers me, which is that the mm tree is doing horribly 
> on 1k and 2k block sizes.  I looks like readahead is not functioning 
> properly for these requst sizes.

There are several problems with readahead under specific circumstances.  I
need to have a session with it.

