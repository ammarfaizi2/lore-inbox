Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWCFNKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWCFNKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 08:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWCFNKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 08:10:41 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:33638 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932190AbWCFNKk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 08:10:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UtzhpRV0IQY4996cFxQkyjAdaljjyhR7AS4dR6XBFS4gvGQHYX8qadIr9+NhW18jO+ZXqi1iPR8/Rgfk7ucwIX7pXXfhCiuTkWq2RzwJc03TKR6pLqaskXG04f82SBx0g32I4t1ci5RQBZcHTQ0qDOBee806UoLb6OqTfRdQoUU=
Message-ID: <35fb2e590603060510k6b5fc748jd0dd9dc193d590d9@mail.gmail.com>
Date: Mon, 6 Mar 2006 13:10:36 +0000
From: "Jon Masters" <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "Helge Hafting" <helge.hafting@aitel.hist.no>
Subject: Re: [OT] inotify hack for locate
Cc: "Chris Ball" <cjb@mrao.cam.ac.uk>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <440C0175.7040909@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>
	 <yd3bqwkbgsi.fsf@islay.ra.phy.cam.ac.uk>
	 <35fb2e590603051704k120e0257wb39c3e3eb1cf0b49@mail.gmail.com>
	 <440C0175.7040909@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> Jon Masters wrote:
>
> >You're right. What I want really is to be able to bind to a netlink
> >socket and get told about particular file IO operations I'm interested
> >in for the /whole/ of a filesystem. The same kind of thing that real
> >time anti-virus/anti-spam people want to do anyway.

> Do they?
> I thought all this mail processing could be done in the mailserver
> and/or mail reader.  Why detect spam by looking for generic file
> creation when you can trivially tap into mail as it arrives?

Because it's not just email :-) These guys want to be able to filter
/every/ file no matter how it is accessed.

> As for the non-existent virus problem - it is mostly prevented
> by users not being administrators.  And you can go further
> with a readonly /usr and a noexec /home.

That's definately OT - I was simply saying that there are
anti-spam/anti-virus products which run on Linux that use hooks to do
this at the VFS level. So that you don't need to modify
Samba/Mailserver/NFS/everything else.

Jon.
