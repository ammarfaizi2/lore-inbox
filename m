Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUBPUbz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUBPUbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:31:55 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:45933 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265897AbUBPUby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:31:54 -0500
Date: Mon, 16 Feb 2004 21:47:21 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Michael Grimborounis <mgrimbor@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: INSTALL_PATH question: Makefile bug?
Message-ID: <20040216204721.GA2977@mars.ravnborg.org>
Mail-Followup-To: Michael Grimborounis <mgrimbor@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20040216120731.13715.qmail@web12901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216120731.13715.qmail@web12901.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 04:07:31AM -0800, Michael Grimborounis wrote:
> Hi,
> 
> I have a question regarding the way INSTALL_PATH is set up in the top
> level Makefile. I can pass a value or uncomment it, like the comments
> in the makefile suggest. But then if INSTALL_MOD_PATH is undefined,
> INSTALL_PATH is unset by the following statements:
> 
> 
> ifndef INSTALL_MOD_PATH
> INSTALL_PATH=
> endif
> export INSTALL_MOD_PATH

I have checked latest 2.6 kernel, and the 2.4 kernel src that I had
lying around. In neither of these I could fine the above statements.

	Sam
