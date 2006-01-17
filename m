Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWAQTGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWAQTGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWAQTGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:06:48 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:22560 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964783AbWAQTGr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:06:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=E3BgcyCFoiXi3stVwGjyJdlU1X///M9AhsAq3UOGr82yY5j1qvAGU2HaVl1QKmmZ7waGPpJM9EStlvkbUlgIchdk/GQiBb4TbNB2QaCWRlmzhrsxe1lvRgRmWnRT1St32z4IG7Gt1NH81LHQ9xQlwhOBkLI2BY/YCTfOdIHMqvo=
Date: Tue, 17 Jan 2006 20:06:23 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc1
Message-Id: <20060117200623.e8226a74.diegocg@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0601170946050.3240@g5.osdl.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
	<20060117183916.399b030f.diegocg@gmail.com>
	<Pine.LNX.4.64.0601170946050.3240@g5.osdl.org>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 17 Jan 2006 10:25:49 -0800 (PST),
Linus Torvalds <torvalds@osdl.org> escribió:


> Is this useful to you? I dunno.  I thought I'd spread the git gospel and 
> see if somebody gives me a "Halleluja!"

Yes, this could be useful for this task (and looking what files are
created/deleted aswell), but it won't catch everything under the sun - 
adding support for a new device in a already existing driver, for 
example, or subtle changes in the semantics of a syscall, or adding
yet another sockopt() option; there're many small changes that are
"important".

For now, I just look at the subject line of every mail sent to the 
git-commits-head mailing list and decide from a quick look if
the change is important or not. It's a very fast operation so 
looking at a couple of hundreds of emails each day doesn't take
more than a couple of minutes; I waste most of the time trying
to understand what the change does to write a comprehensible
description and format everything to put it in the "·$%&/( crappy
HTML forms that wikis use. I agree that asking developers to "mark"
important changes wouldn't work well, so I guess this is the only
100% reliable method. Well, kernel releases are taking two months to
be released, so i guess I should not try to do everything as soon
as it is merged in the first two weeks but do the work in small 
chunks.
