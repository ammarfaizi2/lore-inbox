Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVAQN3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVAQN3k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 08:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbVAQN2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 08:28:16 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:62599 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262795AbVAQN17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 08:27:59 -0500
Subject: Re: Linux Kernel Audit Project?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41EB6BD6.5070702@comcast.net>
References: <41EB6691.10905@comcast.net>  <41EB6BD6.5070702@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105962233.12709.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 17 Jan 2005 12:23:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-17 at 07:40, John Richard Moser wrote:
> On the same line, I've been graphing Ubuntu Linux Security Notices for a
> while.  I've noticed that in the last 5, the number of kernel-related
> vulnerabilities has doubled (3 more).  This disturbs me.

I've been monitoring the kernel security stuff for a long time too.
There are several obvious trends and I think most are positive

- Tools like coverity and sparse are significantly increasing the number
of flaws found. In particular they are turning up long time flaws in
code, but they also mean new flaws of that type are being found. People
aren't really turning these tools onto user space - yet -

- We get bursts of holes of a given type. If you plot things like
"buffer overflow" "structure passed to user space not cleaned" "maths
overflow check error" against time you'll see they show definite
patterns with spikes decaying at different rates towards zero.

There are also people other than Linus who read every single changeset.
I do for one.

Alan

