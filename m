Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271165AbTGPWUR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271161AbTGPWOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:14:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:58537 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271152AbTGPWMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:12:03 -0400
Date: Wed, 16 Jul 2003 15:19:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what's left for 64 bit dev_t
Message-Id: <20030716151939.1762a3cf.akpm@osdl.org>
In-Reply-To: <20030716221154.GA3051@kroah.com>
References: <20030716184609.GA1913@kroah.com>
	<20030716130915.035a13ca.akpm@osdl.org>
	<20030716210253.GD2279@kroah.com>
	<20030716141320.5bd2a8b3.akpm@osdl.org>
	<20030716213607.GA2773@kroah.com>
	<20030716150010.6ba8416f.akpm@osdl.org>
	<20030716221154.GA3051@kroah.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> Ok, to change the topic a bit, what's left to do on the 64bit dev_t
> stuff?

I don't know, really.  I've asked this of Andries several times and either
he doesn't know either, or I didn't understand the answer.

But there have been no problems with the code in -mm for a couple of months.

>  I know your tree has some support, but there was rumors that
> more was really needed to finish this off right.
> 
> Any ideas?  Thoughts?  Patches?  :)

The fact that the code has not been tested on ppc and, presumably, several
other platforms is a problem, but I guess that'll work itself out.

The situation at present is that Linus will take the patches, but I ain't
sending them because viro has expressed oblique concerns over the approach.
 I'd like to get his take on it before proceeding.  But he has vanished
again.  However I do expect that he'll get a chance to review and comment on the
changes soon.

The other concern is the unknown amount of followup work which is needed. 
All I can say there is that the kernel will continue to work in the areas
which have been exercised by testers of the -mm kernels.

I expect we'll end up just jamming it in and seeing what happens.
