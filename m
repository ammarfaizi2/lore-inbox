Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTEINlN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 09:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTEINlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 09:41:13 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:35834 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262493AbTEINlM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 09:41:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
Date: Fri, 9 May 2003 08:53:04 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200305081546_MC3-1-3809-363E@compuserve.com>
In-Reply-To: <200305081546_MC3-1-3809-363E@compuserve.com>
MIME-Version: 1.0
Message-Id: <03050908530400.11221@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 May 2003 14:43, Chuck Ebbert wrote:
> > Have you tried catching the display IO ???
>
>   Not in a million years -- display drivers work by pure magic AFAIC.
>
> > HSM has existed on UNIX based machines for a long time.
>
>   Show me three HSM implementations for Linux and I'll show you three
> different mechanisms. :)

Actually... I think they all use the same one (Even the Solaris/IRIX/Cray ones
do that). All of them provide a filesystem interface via VFS. The Linux ones
were implemented via the "userfs" core or NFS.

There is also OpenAFS which gives access to a remote HSM... but that can
be considered just a NFS equivalent.
