Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269458AbUJUJag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269458AbUJUJag (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269056AbUJUJ1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:27:52 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:35701 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269399AbUJUJ0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:26:40 -0400
Message-ID: <417780CB.4060106@yahoo.com.au>
Date: Thu, 21 Oct 2004 19:26:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: ncunningham@linuxmail.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Proposal: Desktop kernel bk tree/patchset.
References: <1098344977.4146.21.camel@desktop.cunninghams>
In-Reply-To: <1098344977.4146.21.camel@desktop.cunninghams>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi all.
> 
> I want to get some feedback. I'm considering making a tree/patchset
> aimed at the desktop user: Linus kernel + PM, USB and so on patches,
> Win4Lin patches and perhaps [I/O] scheduler improvements.
> 
> What do people think?
> 

I don't think it would be a really good idea to have an official tree
for desktop users. A staging area for desktop improvements, sure that
would be no problem. But if you really have some good improvements,
they should eventually get into the mainline kernel where you can
expect a pretty good (or not terribly bad) review and testing process.

On the other hand, I understand you're probably frustrated at the slow
pace and politics of getting more ambitious patches into the kernel.

I'd go for angle of aiming to get things into -mm. Andrew generally
doesn't mind brewing things up there, even if there is no clear path
for merging into 2.6 at the time... so long as they're pretty stable
and not going to cause rejects all over the tree, of course.

Just my two cents.
