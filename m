Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUCGBe6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 20:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbUCGBe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 20:34:58 -0500
Received: from [65.37.126.18] ([65.37.126.18]:40599 "EHLO the-penguin.otak.com")
	by vger.kernel.org with ESMTP id S261735AbUCGBe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 20:34:56 -0500
Date: Sat, 6 Mar 2004 17:35:07 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: server migration
Message-ID: <20040307013507.GB13908@the-penguin.otak.com>
References: <20040305181322.GA32114@the-penguin.otak.com> <200403070133.07784.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403070133.07784.vda@port.imtp.ilyichevsk.odessa.ua>
X-Operating-System: Linux 2.6.4-rc1-mm1 on an i686
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko [vda@port.imtp.ilyichevsk.odessa.ua] wrote:
> On Friday 05 March 2004 20:13, Lawrence Walton wrote:
> > Hi all!
> >
> > I tried about four months ago to migrate a busy server to 2.6.0-test9,
> > and failed miserably. Lightly loaded it worked well but as the number
> > of users increased, the number of processes in uninterruptible sleep
> > increased to the hundreds and then the server fell on it's face. I never
> > found out exactly why or what processes where hanging if I guessed it
> > would be openldap.
> 
> Why do you guess? Determine what processes are stuck.
> 
Because I did not expect it to happen, I had lots of users screaming at
me to fix it now, when it did happen. The server had been up sense the
night before. It was not until users started showing up in the morning
that the problem manifested itself.

The point is I was hoping to get a list of things to try to capture in
case it happened again, testing is all well and good, but getting
information from a production box can be valuable, as long as it's not
some odd corner case.

Capturing SysRq-T was on my list to do.
I'll investigate stack pointers, and If I can post stack traces.

I was hoping to get pointers like below before I tried it again.

<snip>
> Compile with stack pointers, capture SysRq-T, post stack traces
> of D processes to lkml.
> --
> vda
> 

-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


