Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTLQBm2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 20:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTLQBm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 20:42:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:47235 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263102AbTLQBm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 20:42:27 -0500
Date: Tue, 16 Dec 2003 17:41:53 -0800
From: Chris Wright <chrisw@osdl.org>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: request: capabilities that allow users to drop privileges further
Message-ID: <20031216174153.G6791@osdlab.pdx.osdl.net>
References: <20031215213912.GA29281@codeblau.de> <20031215144809.A14552@osdlab.pdx.osdl.net> <20031217013008.GA8571@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031217013008.GA8571@codeblau.de>; from felix-kernel@fefe.de on Wed, Dec 17, 2003 at 02:30:08AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Felix von Leitner (felix-kernel@fefe.de) wrote:
> Imagine being able to call "gzip -dc" in a pipe and denying it write
> access to the file system, network I/O and other harmful operations.
> If programs can restrict themselves, we could write email client
> software that uses external untrusted plugins without fear of buffer
> overflows or catching yourself a root kit.

Write some SELinux policies for the email and web server that do what
you'd like.  The LSM infrastructure allows you to control all these
things, and SELinux gives a configuration language to do this with.
Or you can write a simple module to do just what you'd like.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
