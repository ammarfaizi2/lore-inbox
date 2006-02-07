Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbWBGMlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWBGMlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWBGMlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:41:37 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:65028 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S965059AbWBGMlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:41:36 -0500
Date: Tue, 7 Feb 2006 13:42:20 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: Linux 2.6.16-rc1
Message-Id: <20060207134220.454df03d.khali@linux-fr.org>
In-Reply-To: <20060118212022.GA15828@mars.ravnborg.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
	<43CD67AE.9030501@eyal.emu.id.au>
	<20060117232701.GA7606@mars.ravnborg.org>
	<20060118085936.4773dd77.khali@linux-fr.org>
	<20060118091543.GA8277@mars.ravnborg.org>
	<20060118212022.GA15828@mars.ravnborg.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Back on 2006-01-18, you said:
> > > But in the lxdialog case we need to execute the link step, because
> > > what we really try to do is to check if gcc can find a specific
> > > library in the search path.
> > 
> > Will -print-file-name not do the trick for you?
> > 
> > $ gcc -print-file-name=libcurses.so | grep -q /
> > $ echo $?
> > 0
> > $ gcc -print-file-name=libfoobar.a | grep -q /
> > $ echo $?
> > 1
>
> Much better - thanks!
> I will push out a new path tomorrow.

Where's that patch? As I understand it, this issue is still not fixed
in Linus' tree, while it really should be before 2.6.16 is released.

Thanks,
-- 
Jean Delvare
