Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264378AbTLGJRI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 04:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbTLGJRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 04:17:08 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:46855 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S264378AbTLGJRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 04:17:06 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mark Symonds <mark@symonds.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 hard lock, 100% reproducible. 
In-reply-to: Your message of "Sun, 07 Dec 2003 01:07:23 -0800."
             <20031207090723.GV8039@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Dec 2003 20:16:54 +1100
Message-ID: <29654.1070788614@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 01:04:41AM -0800, Mark Symonds wrote:
> I'm not a kernel developer, but here goes: 
> puggy:/usr/src/linux/2.4.23# addr2line c02363dd -e vmlinux
> ??:0

addr2line requires compiling with -g.  You can also do
  ksymoops -m /path/to/your/System.map -A c02363dd
which does not require a recompile.

