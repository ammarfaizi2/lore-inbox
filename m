Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWCFBE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWCFBE0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 20:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWCFBE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 20:04:26 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:23288 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751301AbWCFBEZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 20:04:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i5bHanIOVt5z8PbFrupNK0CZI2NPQ9I3lS9sYTvoHLY73KmzIzu9G8dHBe9dTgU6JW1Dg230PJYsaU7WevwS3iShzujfi48xtZjjBzQTJ2rf4XLnV+16wWQmpCFPXwqdcEXXmZ6xwlLFxdrGtoNxJvT+sWdHpQYUse3HbtKd6SM=
Message-ID: <35fb2e590603051704k120e0257wb39c3e3eb1cf0b49@mail.gmail.com>
Date: Mon, 6 Mar 2006 01:04:24 +0000
From: "Jon Masters" <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "Chris Ball" <cjb@mrao.cam.ac.uk>
Subject: Re: [OT] inotify hack for locate
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <yd3bqwkbgsi.fsf@islay.ra.phy.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>
	 <yd3bqwkbgsi.fsf@islay.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/06, Chris Ball <cjb@mrao.cam.ac.uk> wrote:
> >> On 5 Mar 2006 21:36:19, Jon Masters <jonmasters@gmail.com> said:
>
>    > I'm fed up with those finds running whenever I power on. Has
>    > anyone written an equivalent of the Microsoft indexing service to
>    > update locate's database?

> I think the reason this hasn't been done is that inotify_add_watch()es
> are non-recursive:  you'd need a watch over every directory, and you'd
> need a crawling step (churn, churn) to enumerate the directories to
> add watches for.

You're right. What I want really is to be able to bind to a netlink
socket and get told about particular file IO operations I'm interested
in for the /whole/ of a filesystem. The same kind of thing that real
time anti-virus/anti-spam people want to do anyway.

Thanks for the links, Chris. I've not been following Beagle
development (lost interest after the OLS talk got cancelled) very
closely so wasn't aware of the current implementation.

Jon.
