Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265566AbTGHASW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 20:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbTGHASW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 20:18:22 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:53132 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265566AbTGHAST
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 20:18:19 -0400
Date: Tue, 8 Jul 2003 01:32:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Eric Varsanyi <e0216@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
Message-ID: <20030708003247.GB12127@mail.jlokier.co.uk>
References: <20030707154823.GA8696@srv.foo21.com> <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com> <20030707194736.GF9328@srv.foo21.com> <Pine.LNX.4.55.0307071511550.4704@bigblue.dev.mcafeelabs.com> <Pine.LNX.4.55.0307071624550.4704@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307071624550.4704@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> Try out this one, either over 2.5.74 or over an existing epoll-patched
> 2.4.{20,21} ...

Sorry, can't try it out.
But I have a question anyway :)

Does this correctly free everything when you:

	declare interest in some events on fd 3
	dup2(3,4)
	close(3)
?

-- Jamie
