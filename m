Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270847AbTG0Pqb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 11:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272833AbTG0Pqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 11:46:31 -0400
Received: from oak.sktc.net ([64.71.97.14]:25785 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id S272686AbTG0Pp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 11:45:57 -0400
Message-ID: <3F23F6EB.7070502@sktc.net>
Date: Sun, 27 Jul 2003 10:59:39 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: time for some drivers to be removed?
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain> <20030727153118.GP22218@fs.tum.de>
In-Reply-To: <20030727153118.GP22218@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a pet peeve of mine on Free Software projects in general - The 
Program That Wouldn't Compile.

It would seem to me that in the context of the kernel, what is needed is 
a BROKEN flag.

An item with a BROKEN flag would NOT be built in an ALLYES or ALLMODULE 
configuration - it would require the user to explicitly enable the item 
in the configuration, and the user would be notified that the module in 
question was not compiling/linking the last time the configuration data 
was updated by the kernel team.

That way, a busted item would not be built by default, and the item's 
users would be motivated to correct it (and thus remove the stigma of 
the BROKEN flag).

If an item stays BROKEN for too long, bu-bye! Obviously no-one cares 
enough to fix it.

But that's just my opinion.

