Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVAYVCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVAYVCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVAYVCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:02:31 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:43222 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262150AbVAYVCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:02:11 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Complex logging in the kernel
To: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 25 Jan 2005 22:01:56 +0100
References: <fa.ch6lht1.iie1hh@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1CtXoz-0000pB-JD@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser <nigelenki@comcast.net> wrote:

> What systems exist for complex logging and security auditing in the kernel?
> 
> For example, let's say I wanted to register my specific code (i.e. a
> security module) to log, and adjust to log level N.  I also want another
> module to log at log level L, which is lower than N.  I want to print
> logs at log level N..+2 and below to the console, but silently log all
> log messages >N+2 to the syslog.

The priority level can be adjusted using the printk sysctl.

See Documentation/sysctl/kernel.txt for details.
