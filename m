Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVGELpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVGELpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 07:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVGELpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 07:45:08 -0400
Received: from serv4.servweb.de ([82.96.83.76]:26828 "EHLO serv4.servweb.de")
	by vger.kernel.org with ESMTP id S261786AbVGELdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 07:33:46 -0400
Date: Tue, 5 Jul 2005 13:33:43 +0200
From: Patrick Plattes <patrick@erdbeere.net>
To: linux-kernel@vger.kernel.org
Cc: Aleksander Pavic <aleksander.pavic@t-online.de>
Subject: Memory leak with 2.6.12 and cdrecord
Message-ID: <20050705113343.GA6349@erdbeere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ho :-),

we have some trouble with the 2.6v kernel tree and CDRecord 2.01 (Debian
Sarge package). If we try to write an 150MB CD the memory fills up to
150MB. The memory will not deallocate after closing cdrecord. Next if we
try to write an 200MB CD the memory will filled up to additional 50MB.

We don't know which part of the software is steals our memory. This only
happens on 2.6, not on an 2.4 system and we can reproduce the bug only
on the asus notebook.

We have tried to find the leak with top and slabtop, but inconclusively. I 
put some information together. The informations are taken from the system 
after burning a 154MB CD. Please have a look at: http://cdrecord.sourcecode.cc . 
I uploaded the files to this address, to avoid high traffic on the lkml.

Thanks for help,
Patrick
