Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUAWPFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266571AbUAWPFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:05:49 -0500
Received: from mail.aei.ca ([206.123.6.14]:55241 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262598AbUAWPFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:05:48 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: vts have stopped working here
Date: Fri, 23 Jan 2004 10:05:35 -0500
User-Agent: KMail/1.5.93
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <224300000.1074839500@[10.10.2.4]> <200401230743.38488.edt@aei.ca> <20040123130535.GA4046@ucw.cz>
In-Reply-To: <20040123130535.GA4046@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401231005.35610.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 23, 2004 08:05 am, Vojtech Pavlik wrote:
> On Fri, Jan 23, 2004 at 07:43:38AM -0500, Ed Tomlinson wrote:
> > Is anyone else having problems with vt(s)?  I can switch between X and vt
> > 1 without problems.  Trying to use any of the other vt(s) fails.
> >
> > A+C+F1 flips from X to vt1
> > A+F2 flips to vt7 (x)
> > A+C+F2 from X does nothing
> >
> > In my logs there are messages about init spawing too fast.  Suspect that
> > these are the processes for the Vt(s) started with:
> >
> > 2:23:respawn:/sbin/getty 38400 tty2
>
> Interesting. The vt's don't exist until something writes to them. So
> most likely X is running on vt2 in your case. As to why the processes
> keep dying - no idea.

No.  X is running on vt7.  Selecting F2,F3,F4,F5,F6 all get you to the X
screen, and these are the ids init complains about in the log.  Interestingly 
this happens on two boxes (K6-III 400 via, P3-1.4G Intel).

Ed
