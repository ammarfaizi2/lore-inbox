Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270721AbTG0KcA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 06:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270722AbTG0KcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 06:32:00 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39811
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270721AbTG0Kb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 06:31:58 -0400
Subject: Re: [RFC] single return paradigm
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samuel Thibault <samuel.thibault@fnac.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030726221655.GB1148@bouh.unh.edu>
References: <20030726221655.GB1148@bouh.unh.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059302602.12754.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jul 2003 11:43:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-26 at 23:16, Samuel Thibault wrote:
> Hi,
> 
> The "single return" paradigm of drivers/char/vt.c:tioclinux() surprised
> me at first glance. But I'm now trying to maintain a patch which adds
> probes at entry and exit of functions for performance instrumenting

gcc will already dop that for you - and the tools already exist to
extract the data I believe (at least Ingo used to have some). When you
tell gcc to build with profiling it provides the right hooks for you to
provide alternate code to the libc profile code
x
