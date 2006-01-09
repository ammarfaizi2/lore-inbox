Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWAIOCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWAIOCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWAIOCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:02:42 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:964 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750814AbWAIOCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:02:42 -0500
From: Grant Coady <gcoady@gmail.com>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH updated]: How to be a kernel driver maintainer
Date: Tue, 10 Jan 2006 01:02:53 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <7eq4s194t3rvc6j7m1jhsk50j9072gddp2@4ax.com>
References: <1136736455.24378.3.camel@grayson> <1136756756.1043.20.camel@grayson> <1136792769.2936.13.camel@laptopd505.fenrus.org> <1136813649.1043.30.camel@grayson>
In-Reply-To: <1136813649.1043.30.camel@grayson>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2006 08:34:09 -0500, Ben Collins <ben.collins@ubuntu.com> wrote:

>
>But it says "your primary code". I'm not sure of another way to put it.
>Obviously, they have to do their work, and their development on
>something that isn't in Linus tree. If they are doing this work, they
>need to make sure that when they diff for patches, that they merge
>changes before diffing. The only way this is close to automatic is with
>git. Any other method requires manually merging.
>
>How else would you explain this without telling them that git is
>required?

I have my name on one driver ;)  Once the driver is in the kernel 
I no longer need worry about the source nor backups of my driver, 
okay?  The primary code is in mainstream, this is how it works for 
'leaf node' driver maintainers, at least from my limited perspective.

During development I had to rediff against -mm_latest, as that is 
how drivers (usually?) start the path to mainstream.  But the only 
part need merging for a new driver is the Kconfig entry, a trivial 
issue?

Cheers,
Grant.

