Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVBFQBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVBFQBl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 11:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVBFQBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 11:01:41 -0500
Received: from main.gmane.org ([80.91.229.2]:4038 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261174AbVBFQB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 11:01:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Dell Inspiron sensors (was: Re: Huge unreliability - does Linux have something to do with it?)
Date: Sun, 6 Feb 2005 16:58:58 +0100
Message-ID: <MPG.1c7035d63901d496989710@news.gmane.org>
References: <5a2cf1f605020401037aa610b9@mail.gmail.com> <20050204121817.GA7721@animx.eu.org> <d120d50005020406441ba6f919@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-219-149.29-151.libero.it
User-Agent: MicroPlanet-Gravity/2.70.2067
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Fri, 4 Feb 2005 07:18:17 -0500, Wakko Warner <wakko@animx.eu.org> wrote:
> > > particular hardware (Dell Inspiron 8100)? I run Linux on 3 other
> 
> Hmm, I guess it's a hit and run. I had replaced:
> 
> 4. Original Hitachi hard driver died horrible death - I returned home
> and heard it making grinding sounds and hitting heads against
> something.

I have a Dell Inspiron 8200, from March 2002. Since end of 
December 2004 I've started having system lockups which at first 
I couldn't identify, although they seemed to be overheating 
related. So I started monitoring the temperatures on all the 
components in my system (I can monitor CPU, GPU and HD temp; 
more on this later), and noticed that the lockups happen when 
the HD temp gets around 40 C. Indeed, they are 99% of the time 
preceded by a loud "click" coming from the HD wereabouts ... 
haven't lost any data yet but I've started backing up 
everything and getting ready to get a replacement HD.

Concerning sensors, though: under Windows I can use the 
i8kfangui applet to monitor all the sensors provided in the 
computer, but under Linux I only seem able to get the CPU 
temperature, using the i8k module, and no other sensor module 
seems to be loadable. Does anybody know how to access the other 
sensors on the Dell Inspiron? Or should I suggest Massimo to 
upgrade the i8k module to add the new sensors (i8kfangui has a 
GPL source code so it shouldn't be a problem) and possibly 
interface it all with the Linux sensors framework?

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

