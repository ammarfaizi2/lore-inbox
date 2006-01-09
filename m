Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWAIN5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWAIN5E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964770AbWAIN5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:57:04 -0500
Received: from terrhq.ru ([81.222.97.18]:29887 "EHLO mail.terrhq.ru")
	by vger.kernel.org with ESMTP id S964778AbWAIN5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:57:02 -0500
From: Yaroslav Rastrigin <yarick@it-territory.ru>
Organization: IT-Territory 
To: Kasper Sandberg <lkml@metanurb.dk>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Date: Mon, 9 Jan 2006 16:56:48 +0300
User-Agent: KMail/1.9
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
References: <174467f50601082354y7ca871c7k@mail.gmail.com> <200601091403.46304.yarick@it-territory.ru> <1136813783.8412.4.camel@localhost>
In-Reply-To: <1136813783.8412.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091656.48355.yarick@it-territory.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kasper,
> > without worrying about my on-the-road availability. 
> > Suspend to disk has nasty tendency to ruin my whole hot live X session, since X can't properly restore VT on resume.
> > Overall performance isn't that bad, either, but I just can't understand, why KATE (Kde more or less advanced editor) takes twice as long to start 
> > as UltraEdit in _emulated_ (VMWare) Windows XP running on this same box.
> i can not take this seriously.. on both my laptop and workstation, the
> kate window is up in less than a second after i either run kate from a
> terminal, or select it in the kde menu..
Well, I could find more or less reasonable explanation of this behaviour - different VM policies of two OSes and 
strangely strong and persistent belief "Free RAM is a wasted RAM" among kernel devs. Free RAM is not a wasted RAM, its a memory waiting to be used ! 
Whenever it is needed by apps I'm launching or working with. 
> 
> unless ofcourse you are not using kde, and kate is the first kde
> application you start, then it will need to load much more than simply
> kate, at which point you cant really say what you are doing, since it
> would be somewhat like comparing half of windows's startup time +
> ultraedit startup time to kate startup time...
No. Fully loaded KDE session (without kdesktop and kwin, since I don't use first and using my own WM instead of second).
So almost all necessary libraries are hot and loaded, and all what's missing is a dozen of Window's and Pixmap's to allocate and two threads to 
handle events. And it takes seconds, not tens of a second, as in UltraEdit case 
> 
> > 
> > So, the question remains the same - whom and how much I need to pay to solve abovementioned problems ?
> > 
> 
> 

-- 
Managing your Territory since the dawn of times ...
