Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267799AbUIJTJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267799AbUIJTJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267806AbUIJTJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:09:27 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:45089 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267799AbUIJTJX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:09:23 -0400
Date: Fri, 10 Sep 2004 21:09:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Bill Adair <biotrace@nildram.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How do I stop make building all modules after reboot?
Message-ID: <20040910190924.GB8799@mars.ravnborg.org>
Mail-Followup-To: Bill Adair <biotrace@nildram.co.uk>,
	linux-kernel@vger.kernel.org
References: <opsd3vx7i3u7wa79@smtp.nildram.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opsd3vx7i3u7wa79@smtp.nildram.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 11:11:57AM +0100, Bill Adair wrote:
> Quick question as above. I'm building an i2c module. If I don't reboot
> the machine "make modules" works as expected and just recompiles my  
> changes.
> After a reboot I have to wait 1 hour + (two smp P3 866s) while all modules  
> are built. I've had a look in the Makefile but can't spot the dependancy.

Something fishy going on here.
Maybe your clock are set backwards when rebooting?

	Sam
