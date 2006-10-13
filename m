Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751642AbWJMMMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbWJMMMe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 08:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWJMMMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 08:12:34 -0400
Received: from mail.aei.ca ([206.123.6.14]:59894 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1751641AbWJMMMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 08:12:33 -0400
From: Ed Tomlinson <edt@aei.ca>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: USB performance bug since kernel 2.6.13 (CRITICAL???)
Date: Fri, 13 Oct 2006 08:12:10 -0400
User-Agent: KMail/1.9.1
Cc: Open Source <opensource3141@yahoo.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20061012205651.2853.qmail@web58103.mail.re3.yahoo.com> <1160688386.24931.95.camel@mindpipe>
In-Reply-To: <1160688386.24931.95.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610130812.11157.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 October 2006 17:26, Lee Revell wrote:
> On Thu, 2006-10-12 at 13:56 -0700, Open Source wrote:
> > Yes, I am pretty sure you are right about the timing.  But it shouldn't be that way.  If it is, then there's a bug.
> > 
> > I'm fully willing to accept there is something else I should be doing driver-wise, but it shoudn't require recompiling the stock distribution kernels.  Otherwise, Linux is not competitive with Microsoft Windows in this regard!
> > 
> > I'll try a recompile and report back.  In the meantime, if anyone else has any ideas, please let me know!
> > 
> 
> Yes, I agree that it would be a bug.  If it turns out to be related to
> CONFIG_HZ, ask your distro why they rolled it back from 1000 to 250Hz.

If this turns out to be tied to the HZ rate its a bug.  It _should_ not be using
this timing to do this ergo bug.  You may be able to bypass by using 1000Hz
but this is not a fix...

Ed Tomlinson
