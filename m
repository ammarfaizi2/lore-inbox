Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWAORhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWAORhD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 12:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWAORhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 12:37:01 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:56850 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S932107AbWAORhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 12:37:01 -0500
Message-ID: <43CA883B.2020504@superbug.demon.co.uk>
Date: Sun, 15 Jan 2006 17:36:59 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mail/News 1.5 (X11/20060112)
MIME-Version: 1.0
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: X killed
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a python application that kills X. I.e. the X process terminates, 
and all X programs receive broken links to the display and therefore 
also exit.

The problem is, this python application is not supposed to kill 
anything, so I think it is a bug in X, but I cannot find any way to 
trace the fault. Even gdb says the application was killed, so exited 
normally, and results in no back trace.

Is there any way in Linux to find out who did the "killing" ?

James
