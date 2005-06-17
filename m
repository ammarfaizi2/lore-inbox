Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVFQSzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVFQSzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVFQSys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:54:48 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:29386 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262059AbVFQSwG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:52:06 -0400
Message-ID: <42B31CC2.6040004@imag.fr>
Date: Fri, 17 Jun 2005 20:56:02 +0200
From: Raphael Jacquot <raphael.jacquot@imag.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Charles Leggett <CGLeggett@lbl.gov>
CC: linux-kernel@vger.kernel.org
Subject: Re: system hangs with no warning or errors
References: <1119033617.4663.90.camel@annwm.lbl.gov>
In-Reply-To: <1119033617.4663.90.camel@annwm.lbl.gov>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Leggett wrote:
> I know that this is a very anemic bug report, I'm sorry I can't offer
> any more information. Any suggestions for things to look for, what
> to instrument to get more detailed information, or things to try are
> welcome.

I am running on an epia MII 12000 and have seen this kind of behavior.
After switching my logger to flush everytime instead of caching, I have
a couple of PREEMPT labeled oopses.
removing preempt got rid of the crashes.
(my issue seems to crash way more often than this)
