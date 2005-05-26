Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVEZMX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVEZMX2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 08:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVEZMX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 08:23:28 -0400
Received: from coderock.org ([193.77.147.115]:44686 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261341AbVEZMXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 08:23:23 -0400
Date: Thu, 26 May 2005 14:23:15 +0200
From: Domen Puncer <domen@coderock.org>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: 2.6.12-rc2: Compose key doesn't work
Message-ID: <20050526122315.GA3880@nd47.coderock.org>
References: <4258F74D.2010905@keyaccess.nl> <20050414100454.GC3958@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414100454.GC3958@nd47.coderock.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still true for 2.6.12-rc5. Should probably be fixed before final.

On 14/04/05 12:04 +0200, Domen Puncer wrote:
> On 10/04/05 11:52 +0200, Rene Herman wrote:
> > Hi Vojtech.
> > 
> > I have mapped my right windows key to "Compose" in X:
> ...
> > 
> > This worked fine upto  2.6.11.7, but doesn't under 2.6.12-rc2. The key 
> > doesn't seem to be doing anything anymore: "Compose-'-e" just gets me 
> > "'e" and so on.
> 
> I can confirm this, right windows key works as scroll up, so it might
> be related to recent scroll patches.
> 
> A quick workaround is to:
> echo -n "0" > /sys/bus/serio/devices/serio1/scroll
> 
> serio1 being the keyboard here.
> 
> Btw. is that "-n" really necessary? Had too look at the code to figure
> out why it's not working :-)
> 
> > 
> > X is X.org 6.8.1, keyboard is regular PS/2 keyboard, directly connected.
> 
> Same here.
