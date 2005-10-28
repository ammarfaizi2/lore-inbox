Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbVJ1JmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbVJ1JmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 05:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbVJ1JmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 05:42:20 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:55270 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965205AbVJ1JmU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 05:42:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QwepvxRUcpcVrkXVvywKbO9YNXR2yGjJelm+R++C1sa9mqOOdwAhdP+sFks/b/6RD1FCz1U7T0YDj5mdGYQevjt1GRhhpEWwtAkNZddKP1l/2+C3SZVYe0m3XFm4QC+OzStWg3+iy7FqhjP/TSz/FgsVgfpI2MLrZER4dPMlmTI=
Message-ID: <35fb2e590510280242h53c8c444t8d285198d7c6730f@mail.gmail.com>
Date: Fri, 28 Oct 2005 10:42:18 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Paul Albrecht <palbrecht@qwest.net>
Subject: Re: yet another c language cross-reference for linux
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000701c5db43$86209060$25c60443@oemcomputer>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <000501c5daf1$bbd37c60$e8c90443@oemcomputer>
	 <35fb2e590510270822q39db180fh530ce80bb9ec57ba@mail.gmail.com>
	 <000701c5db43$86209060$25c60443@oemcomputer>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Paul Albrecht <palbrecht@qwest.net> wrote:

> I simply disagree that the lxr user interface is useable for code study.

Although many people use it for that, so it must be useable.

> The problem with the lxr interface stems from the author's decision to use basic
> html for query responses to the database;

You don't cite an example of where this fails. The only practical
limitation I've seen in lxr is that it doesn't index certain symbols
which arrive through complex defines (and this is a place where asking
the compiler for help *is* useful).

> Actually, I'm uninterested in data presentation issues or I'd make the
> changes myself. What's really different about my cross-reference application
> is that the database is generated using compiler output.

That is a good idea.

> the cross-reference database is coherent in the sense that its derived from
> a particular kernel compilation. The advantage of this approach is that it
> reduces the size and ensures the integrity of the cross-reference database.

coherency is the wrong term here. The database in both should be as
they're derived from a static kernel tree (if not, then there are
other problems). But I'll agree that your idea (I haven't yet checked
the implementation - it was very short) in theory is a good one. LXR
still works great though :-)

Jon.
