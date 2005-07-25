Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVGYTR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVGYTR5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVGYTR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:17:57 -0400
Received: from tantale.fifi.org ([64.81.251.130]:17794 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261417AbVGYTRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:17:11 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Bernd Petrovitsch <bernd@firmix.at>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Grant Coady <lkml@dodo.com.au>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Puneet Vyas <vyas.puneet@gmail.com>
Subject: Re: xor as a lazy comparison
References: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr>
	<kis7e1d4khtde78oajl017900pmn9407u4@4ax.com>
	<Pine.LNX.4.61.0507242342080.9022@yvahk01.tjqt.qr>
	<42E4131D.6090605@gmail.com>
	<1122281833.10780.32.camel@tara.firmix.at>
	<1122314150.6019.58.camel@localhost.localdomain>
	<1122318659.1472.14.camel@mindpipe>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 25 Jul 2005 12:16:56 -0700
In-Reply-To: <1122318659.1472.14.camel@mindpipe>
Message-ID: <87ackaitlj.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> On Mon, 2005-07-25 at 13:55 -0400, Steven Rostedt wrote: 
> > Doesn't matter. The cycles saved for old compilers is not rational to
> > have obfuscated code.
> 
> Where do we draw the line with this?  Is x *= 2 preferable to x <<= 2 as
> well?

Depends if you want to multiply by 2 or 4 :-)

Phil.
