Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275080AbTHGGYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 02:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275105AbTHGGYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 02:24:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:5587 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275080AbTHGGYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 02:24:20 -0400
Date: Wed, 6 Aug 2003 23:22:51 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: russ@ashlandhome.net
Subject: Re: Fw: 2.6.0: lp not working
Message-Id: <20030806232251.03807d00.rddunlap@osdl.org>
In-Reply-To: <20030806223820.5578d282.rddunlap@osdl.org>
References: <20030806130452.722d7fb2.rddunlap@osdl.org>
	<20030806223820.5578d282.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003 22:38:20 -0700 "Randy.Dunlap" <rddunlap@osdl.org> wrote:

| | Date: Tue, 5 Aug 2003 22:43:17 -0700 (PDT)
| | From: Russell Whitaker <russ@ashlandhome.net>
| | To: linux-kernel@vger.kernel.org
| | Subject: 2.6.0: lp not working
| | 
| | 
| | Hi
| | Edited lilo.conf so I can boot either kernel-2.6.0-test2
| | (default) or kernel-2.4.21, using hda1.
| | 
| | lpr a small file, no print. ctrl-alt-del and rebooted using
| | 2.4.21, file printed. Checked the two config files and could
| | not find any difference in this area.
| | 
| | Printer is a Panasonic dot-matrix running in text mode.
| | Also using patch bk5.
| 
| Is "Parallel Printer support" built into your kernel or built as a
| module?  If built as a module, are you sure that the module is
| loaded?  If modular, please provide contents of /proc/modules
| when you try to print.

I dug out my old (Panasonic) dot matrix printer (only parallel port
printer that was handy) and some continuous/fan-fold paper.
I'm using 2.6.0-test2 and it prints.  However, it's not in
USASCII characters that I can read, but I suspect that's a
different problem.  The good news is that my PC sends data to it.

--
~Randy
~ http://developer.osdl.org/rddunlap/ ~ http://www.xenotime.net/linux/ ~
