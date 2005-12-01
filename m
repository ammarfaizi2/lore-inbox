Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVLAUiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVLAUiD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 15:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVLAUiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 15:38:03 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:41667 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932460AbVLAUiC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 15:38:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rEt+p31O03ECW9VuT4StAUiAbqo+AzgfZ4A7COoCLhpb/z6ExrhVm2kpeOTRDVWolI2po0hBrucLvV2s0lWpYQNAVT0UHLE42BGvMeWY2Hq29EtMq1wTLGzVZrhMhU+29a15jAS/Tt8hNia77uXNxcgPEio1nNRTwrB/NphdPdU=
Message-ID: <121a28810512011238t642b7385y@mail.gmail.com>
Date: Thu, 1 Dec 2005 21:38:01 +0100
From: Grzegorz Nosek <grzegorz.nosek@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] race condition in procfs
Cc: vserver@list.linux-vserver.org, linux-kernel@vger.kernel.org
In-Reply-To: <121a28810511300923h24ebe39y@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <121a28810511282317j47a90f6t@mail.gmail.com>
	 <121a28810511290604m68c56398t@mail.gmail.com>
	 <1133274524.6328.56.camel@localhost.localdomain>
	 <121a28810511290639g79617c85h@mail.gmail.com>
	 <Pine.LNX.4.58.0511290945380.7838@gandalf.stny.rr.com>
	 <121a28810511300641pca9596fl@mail.gmail.com>
	 <1133363652.25340.17.camel@localhost.localdomain>
	 <121a28810511300729p6983c9a2x@mail.gmail.com>
	 <1133367951.6635.12.camel@localhost.localdomain>
	 <121a28810511300923h24ebe39y@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2005/11/30, Steven Rostedt <rostedt@goodmis.org>:
> >
> > The oops happened at address a01b50eb.  Could you go into the compiled
> > directory run gdb on vmlinux and type li *0xa01b50eb and show what you
> > get.

It turned out to be a bug in the vserver patches. Sent to maintainer.
As it's not a mainline issue, I'm not bothering you any more. Thanks
for debugging tips :)

Best regards,
 Grzegorz Nosek
