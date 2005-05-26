Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVEZPsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVEZPsk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 11:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVEZPsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 11:48:39 -0400
Received: from animx.eu.org ([216.98.75.249]:17831 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261571AbVEZPsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 11:48:36 -0400
Date: Thu, 26 May 2005 11:45:09 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Domen Puncer <domen@coderock.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: 2.6.12-rc2: Compose key doesn't work
Message-ID: <20050526154509.GB9443@animx.eu.org>
Mail-Followup-To: Domen Puncer <domen@coderock.org>,
	Rene Herman <rene.herman@keyaccess.nl>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <4258F74D.2010905@keyaccess.nl> <20050414100454.GC3958@nd47.coderock.org> <20050526122315.GA3880@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050526122315.GA3880@nd47.coderock.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Domen Puncer wrote:
> Still true for 2.6.12-rc5. Should probably be fixed before final.

I also have a problem with 2.6.12-rcX and ps/2 keyboard.  I would say it's
the same key we're talking about.  It does not work at the console nor in X
(showkey at the console does not see it).  It works with a USB keyboard.  My
"compose" is mapped to the menu key beside the right windows key.

I do wish they'd fix it, because I use this key (kinda like another ALT key)
more than my compose key (again, the menu key, not the right win logo key)

> > On 10/04/05 11:52 +0200, Rene Herman wrote:
> > > Hi Vojtech.
> > > 
> > > I have mapped my right windows key to "Compose" in X:
> > ...
> > > 
> > > This worked fine upto  2.6.11.7, but doesn't under 2.6.12-rc2. The key 
> > > doesn't seem to be doing anything anymore: "Compose-'-e" just gets me 
> > > "'e" and so on.
> > 
> > I can confirm this, right windows key works as scroll up, so it might
> > be related to recent scroll patches.
> > 
> > A quick workaround is to:
> > echo -n "0" > /sys/bus/serio/devices/serio1/scroll
> > 
> > serio1 being the keyboard here.
> > 
> > Btw. is that "-n" really necessary? Had too look at the code to figure
> > out why it's not working :-)
> > 
> > > 
> > > X is X.org 6.8.1, keyboard is regular PS/2 keyboard, directly connected.
> > 
> > Same here.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
