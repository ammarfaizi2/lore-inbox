Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTIEA45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 20:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTIEA45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 20:56:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:48274 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261898AbTIEA4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 20:56:55 -0400
Message-ID: <32862.4.4.25.4.1062723410.squirrel@www.osdl.org>
Date: Thu, 4 Sep 2003 17:56:50 -0700 (PDT)
Subject: Re: make checkconfig problem
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <sam@ravnborg.org>
In-Reply-To: <20030904202737.GA10691@mars.ravnborg.org>
References: <20030904123452.62dd732e.rddunlap@osdl.org>
        <20030904202737.GA10691@mars.ravnborg.org>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>, <kai.germaschewski@gmx.de>,
       <cherry@osdl.org>, <torvalds@osdl.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Sep 04, 2003 at 12:34:52PM -0700, Randy.Dunlap wrote:
>>
>> You probably already know this...
>>
>> Someone mentioned to me that 'make checkconfig' isn't working.
>> However, 'make checkincludes' does work.
>
> It had crossed my mind, and my plan was actually to get rid of them since
> the scripts were not updated. Good to see you are looking into this now.

They work now, and I'd like to add 'checkversion.pl' as well.

> If we want to keep them in the kernel, I suggest a new naming:
> configcheck:
> includecheck:
>
> This follows the *config pattern, but suffixed with check.

OK, I don't mind how they are spelled.

> A tangent - could it be possible to build this into sparse instead? The plan
> is to give it more kernel awareness anyway, so it should
> be simple to check for the above as well.

I don't know, but I'll discuss it with Dave Olien.

Thanks,
~Randy



