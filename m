Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266468AbUBQT1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266516AbUBQT1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:27:20 -0500
Received: from stewie.egr.unlv.edu ([131.216.22.9]:18406 "EHLO
	mail.egr.unlv.edu") by vger.kernel.org with ESMTP id S266468AbUBQT1T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:27:19 -0500
Subject: Re: fh_verify: no root_squashed access hundreds of times a second
	again
From: Andrew Gray <grayaw@Egr.UNLV.EDU>
To: linux-kernel@vger.kernel.org
Organization: University of Nevada Las Vegas
Message-Id: <1077046038.20175.13.camel@blargh.egr.unlv.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Tue, 17 Feb 2004 11:27:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about tracking down whoever is trying to do all these illegal
> accesses and stop them?  6000 attempts per minute seems a
> waste of resources, whether malicious or ill-configured. 

I am, of course, working this angle as well.  However, I was hoping to
find out what, specifically, is causing these messages.  Preferably, how
to stop them or mute them for the short-term.  Having the log server
rotate 4GB log files every 24 hours because the kernel is almost DOSing
itself is counterproductive.


