Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbUKDQAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbUKDQAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 11:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbUKDQAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 11:00:53 -0500
Received: from host.atlantavirtual.com ([209.239.35.47]:39309 "EHLO
	host.atlantavirtual.com") by vger.kernel.org with ESMTP
	id S262242AbUKDQAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 11:00:47 -0500
Subject: Re: Installing software on a knoppix CD
From: kernel <kernel@crazytrain.com>
Reply-To: kernel@crazytrain.com
To: Bill Davidsen <davidsen@tmr.com>
Cc: Sai Prathap <saiprathap@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <418940AA.7000809@tmr.com>
References: <69cfd1b80411031106663a1cc8@mail.gmail.com>
	 <418940AA.7000809@tmr.com>
Content-Type: text/plain
Message-Id: <1099532897.3448.4.camel@crazytrain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Nov 2004 11:01:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-03 at 15:33, Bill Davidsen wrote:
> Sai Prathap wrote:
> > Hi,
> > 
> > I have a question regarding knoppix. If we boot from a knoppix CD, Is
> > it possible to get any software installed on it ? Because, whenever I
> > try to install something  it says its not writable. Please advice.
> 

Try a different architecture - ovlfs - slax or linux-live scripts.

With this approach you can install or remove packages (in RAM, of
course) as you need.  Customize your distro, run the scripts, burn your
ISO, boot something, then install or remove programs.  Again, none of
these changes will exist upon reboot.  

Slax takes it a step further, incorporating 'modules', which you can
load (or not) as you see fit.  These can reside elsewhere, USB media,
firewire, etc.  

Would be really nice, though, if you could make a bootable ISO on a
multi-session CD, leaving a free session to burn while running from
first session.

-fd



