Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWAAVdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWAAVdv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 16:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWAAVdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 16:33:51 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:42435 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932272AbWAAVdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 16:33:50 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Lee Revell <rlrevell@joe-job.com>
cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Bradley Reed <bradreed1@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1? 
In-reply-to: Your message of "Sun, 01 Jan 2006 13:57:14 CDT."
             <1136141835.13079.49.camel@mindpipe> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jan 2006 08:33:47 +1100
Message-ID: <29832.1136151227@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell (on Sun, 01 Jan 2006 13:57:14 -0500) wrote:
>On Sun, 2006-01-01 at 14:31 +0000, Alistair John Strachan wrote:
>> On Sunday 01 January 2006 09:14, Arjan van de Ven wrote:
>> > On Sat, 2005-12-31 at 20:29 +0200, Bradley Reed wrote:
>> > > I have tried MPlayer versions 1.0pre6, 1.0pre7, and cvs from today and
>> > > they all work fine under 2.6.14 and 2.6.14-rt21/22.
>> > >
>> > > I booted into 2.6.15-rc7-rt1 and the same MPlayer binaries segfault on
>> > > every video I try and play. Yes, I have nvidia modules loaded, so won't
>> > > get much help, but thought someone might like to know.
>> >
>> > you know, you could have done a little bit more effort and reproduced
>> > this without the binary crud... it's not that hard you know and it shows
>> > that you actually care about the problem enough that you want to make it
>> > worthwhile for people to look into it.
>> 
>> REPORTING-BUGS should probably be fixed to make the points you repeatedly have 
>> to make. I agree 100% that people should not be reporting easily reproducible 
>> bugs with proprietary drivers loaded; what's a reboot to them?
>> 
>> Let's add something to REPORTING-BUGS about tainted kernels and/or proprietary 
>> drivers. A quick grep of this file from 2.6.15-rc6 gives me no hits for 
>> "proprietary", "tainted" or "binary".
>> 
>
>Heh, wow, that's a serious omission.  It would explain why so many users
>post tainted bug reports then act like we're fanatics for telling them
>not to do that ;-)

Historically this was covered in the kernel FAQ, see
http://www.kernel.org/pub/linux/docs/lkml/#s1-18.

