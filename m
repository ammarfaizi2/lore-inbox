Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264214AbTIIPm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 11:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264194AbTIIPm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 11:42:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:37312 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264214AbTIIPm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 11:42:28 -0400
Date: Tue, 9 Sep 2003 08:39:44 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Revert swsusp to -test3 state
In-Reply-To: <20030906213101.GA1385@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0309090837020.919-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This reverts swsusp to known good state in -test3. Patrick seen
> power/main.c parts, and as its what he told me to do, he should be
> happy with it.  Please apply,

No, it's not. This is what I said: 

<quote>

Please send a patch that only removes the calls to swsusp_* from 
pm_{suspend,resume}. That would be a minimal patch. 

</quote> 

Since it's so trivial, and you have such a hard time cooperating in the 
first place, I can fix it up myself. I will post an updated patch later 
today. 


	Pat

