Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbUC0OsW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 09:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUC0OsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 09:48:21 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:47771 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261778AbUC0OsU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 09:48:20 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 27 Mar 2004 14:48:18 -0000
MIME-Version: 1.0
Subject: Re: Somewhat OT: gcc, x86, -ffast-math, and Linux
Message-ID: <40659432.5955.326A2643@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had very funny results building a Quake2 MOD I am coder on (Quake2 
dday).

Using -ffast-math made the HMG (e.g.) fire off aim by say 25º.  Do a 
recompile with NO code change, and the HMG would be OK... but then 
the pistol starting firing all over the show.  Do another rebuild (NO 
code change) and then the rifle showed this... etc. etc.

Every new build produced a different result, although the code was 
untouched.

I had to build leaving `--fast-math' option out in the end to get it 
to work correctly.

Maybe bad coding here, but what I didn't understand was why the 
result was so random (like each weapon has it's own code - so why one 
routine worked then after a rebuild didn't and vice versa, I don't 
know).

Nick
(Not subscribed to list).

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

