Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVDLPC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVDLPC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVDLPCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:02:08 -0400
Received: from [193.112.238.6] ([193.112.238.6]:32128 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S262402AbVDLPAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 11:00:39 -0400
Subject: Re: Exploit in 2.6 kernels
From: John M Collins <jmc@xisl.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <425BBDF9.9020903@ev-en.org>
References: <1113298455.16274.72.camel@caveman.xisl.com>
	 <425BBDF9.9020903@ev-en.org>
Content-Type: text/plain
Organization: Xi Software Ltd
Date: Tue, 12 Apr 2005 16:00:34 +0100
Message-Id: <1113318034.3105.46.camel@caveman.xisl.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to everyone for the pointers on this one I've rebuilt the kernels
and we'll see what happens.

Seems like they got in because on most of the machines I had an ancient
sshd_config which allowed Protocol 1. When I installed newer sshds the
newer sshd_config got stuck in as a ".rpmnew" file.

>From what I can make out the "visitor" was from Interbusiness.it if
anyone is interested.


John Collins Xi Software Ltd www.xisl.com Tel: +44 (0)1707 886110
(Direct) +44 (0)7799 113162 (Mobile)

