Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbUCMOFg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 09:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbUCMOFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 09:05:32 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:33943 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S263097AbUCMOF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 09:05:28 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 13 Mar 2004 14:05:26 -0000
MIME-Version: 1.0
Subject: Re: Build problem smbfs/file.c
Message-ID: <40531526.2716.2357E62B@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I got a build warning:
> 
> ... type character `z'...
> fs/smbfs/file.c: 272 too many arguments for format.
> 
> Line 272:
> 
> PARANOIA("%s/%s validation failed, error=%zd\n"
> 
> Ummm.  I removed the `z' from error=%zd\n" - it appears to be rogue, 
> but what do I know ;)
> 
> And no warnings now. Is this as it should be?

OK, replying to myself.

it should be (I believe from looking at other code):

PARANOIA("%s/%s validation failed, error=%Zd\n"

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

