Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265574AbTGHAQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 20:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265615AbTGHAQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 20:16:52 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:10148 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265574AbTGHAQp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 20:16:45 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 7 Jul 2003 17:23:37 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Eric Varsanyi <e0216@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
In-Reply-To: <20030708002444.GA12127@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307071721290.3524@bigblue.dev.mcafeelabs.com>
References: <20030707154823.GA8696@srv.foo21.com>
 <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com>
 <20030707194736.GF9328@srv.foo21.com> <20030707200315.GA10939@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307071506560.4704@bigblue.dev.mcafeelabs.com>
 <20030708002444.GA12127@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > It has to keep (file*, fd) as hashing key. That will work out just fine.
>
> Do you mean epoll has to use (file*,fd) as the hash key?

Basically it wasn't a limit of the architecture itself. It was an
artificial constraint added. I'll post the patch to Andrew->Linus tonight.



- Davide

