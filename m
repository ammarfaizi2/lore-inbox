Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTLWJ2y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 04:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265066AbTLWJ2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 04:28:54 -0500
Received: from mail.enyo.de ([212.9.189.167]:45574 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S265069AbTLWJ2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 04:28:53 -0500
Date: Tue, 23 Dec 2003 10:28:47 +0100
To: jw schultz <jw@pegasys.ws>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: SCO's infringing files list
Message-ID: <20031223092847.GA3169@deneb.enyo.de>
References: <1072125736.1286.170.camel@duergar> <200312221519.04677.tcfelker@mtco.com> <Pine.LNX.4.58.0312221337010.6868@home.osdl.org> <20031223002641.GD28269@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223002641.GD28269@pegasys.ws>
User-Agent: Mutt/1.5.4i
From: Florian Weimer <fw@deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:

> And for the names, perhaps they would care to sue The Open
> Group?

Not the names, but the comments. 8-)

> http://www.opengroup.org/onlinepubs/007904975/basedefs/errno.h.html

The comments were added in Linux 0.99.1, and I'm not sure what was the
source.  For example, Linux has:

#define ENOTTY          25      /* Not a typewriter */

Solaris:

#define ENOTTY  25      /* Inappropriate ioctl for device       */

Current POSIX:

    [ENOTTY]
        Inappropriate I/O control operation.

I couldn't find any historic Minix header files.  Minix 2 has:

#define ENOTTY        (_SIGN 25)  /* inappropriate I/O control operation */
