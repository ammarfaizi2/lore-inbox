Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTJOFFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 01:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbTJOFFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 01:05:47 -0400
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:48614 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S262253AbTJOFFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 01:05:46 -0400
Subject: Re: Strange dcache memory pressure when highmem enabled
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16268.52761.907998.436272@notabene.cse.unsw.edu.au>
References: <16268.52761.907998.436272@notabene.cse.unsw.edu.au>
Content-Type: text/plain
Message-Id: <1066194345.16993.12.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 14 Oct 2003 22:05:45 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-14 at 21:33, Neil Brown wrote:

>  I have a fairly busy NFS server which has been having performance
>  problems lately.  I have managed to work around the problems, but
>  would really like to get the root problem fixed.

Funny, I have seen exactly the same problem, though with a Red Hat
2.4.20 kernel, rather than a vanilla-ish 2.4.

I have a few thousand more entries in my dentry cache on a 2G machine,
but it's still a pitiful number.

What workarounds did you find?

	<b

