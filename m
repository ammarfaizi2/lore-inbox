Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755533AbWKQHV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbWKQHV6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 02:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755534AbWKQHV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 02:21:58 -0500
Received: from raven.upol.cz ([158.194.120.4]:9650 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1755535AbWKQHV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 02:21:56 -0500
Date: Fri, 17 Nov 2006 07:28:48 +0000
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: newsreaders (Re: Looking for recent lkml email)
Message-ID: <20061117072848.GA13287@flower.upol.cz>
References: <20061116162151.GA23930@tumblerings.org> <20061116165235.GA28447@tumblerings.org> <slrnelq3s1.7lr.olecom@flower.upol.cz> <20061116224420.11c201e0.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116224420.11c201e0.zaitcev@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, Pete.

On Thu, Nov 16, 2006 at 10:44:20PM -0800, Pete Zaitcev wrote:
[]
> The good news reader might be a problem. In fact, I'm currently looking
> for one. Criteria:
>  - GUI with support for X clipboard (not just selections)
>  - Ability to bounce to myself
> 
> I use Pan, but it cannot bounce articles. It only saves them, so I have
> to find them (it uses Message-ID for name), open in vi, add "From xxx"
> on top, then do the "Import External mbox" dance in my mailreader.
> In previous Pan the useful trick was to "print" article, and specfy
> your lpr to be a scrip which called sendmail. But they took it away.

The slrn newsreader is text console, so x-terminal+mouse to use X
clipboard.

If you want to bounce message, in slrn there are 2 options:
,--
|  F                  Forward the current article to someone (via email).
|        ESC 1 F        Forward the current article (including all headers).
`--
Tested, works.

Sending is difficult (for a while):
slrn converts "Cc" header to "To", when it sends copies by SMTP, and
removes it from NNTP postings. I've used "Mail-Follow-Up" header, but
now i want to patch slrn with better lkml + gmane.org support (:.

--[OT]--
slrn + gmane.org is a miracle, that enables lkml (and many others MLs)
for me.

BTW. On you web site i've read historical lkml messages, like Linus'
moving from Transmeta, and i saw, that you had news<->lkml bridge.
____
