Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbUAEOUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 09:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264342AbUAEOUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 09:20:42 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:6929 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S264339AbUAEOUl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 09:20:41 -0500
Date: Mon, 5 Jan 2004 16:20:32 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Xavier Bestel <xavier.bestel@free.fr>
Subject: Re: 2.6.0 under vmware ?
Message-ID: <20040105142032.GE11115091@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Xavier Bestel <xavier.bestel@free.fr>
References: <1073297203.12550.30.camel@bip.parateam.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073297203.12550.30.camel@bip.parateam.prv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 11:06:43AM +0100, you [Xavier Bestel] wrote:
> Hi,
> 
> Has anyone managed to make another distro with 2.6 work under vmware ?

2.6.1rc1 works great for me under vmware 4.05 (6030), but that's with an
ancient glibc and /sbin/init that do not know of sysenter among other
things.

There is one regression, though: 2.2.x and 2.4.x can see /dev/fd0 and
/dev/fd1 under vmware. 2.6.1rc1 only find /dev/fd0. Does anyone else see
this?

There's quite a few changes in floppy.c from 2.4 to 2.6 - I couldn't quite
spot what could be the culprit.


-- v --

v@iki.fi
