Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUE3AM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUE3AM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 20:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUE3AM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 20:12:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:64420 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261347AbUE3AMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 20:12:24 -0400
Date: Sat, 29 May 2004 17:08:26 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: rmk+lkml@arm.linux.org.uk, theman@artemio.net, bcollins@debian.org,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] let IEEE1394 select NET
Message-Id: <20040529170826.48612cf9.rddunlap@osdl.org>
In-Reply-To: <40B922EC.8060708@myrealbox.com>
References: <200405291424.43982.theman@artemio.net>
	<20040529121408.GM16099@fs.tum.de>
	<20040529132356.A3014@flint.arm.linux.org.uk>
	<40B922EC.8060708@myrealbox.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2004 16:55:24 -0700 Andy Lutomirski <luto@myrealbox.com> wrote:

| Russell King wrote:
| 
| > On Sat, May 29, 2004 at 02:14:08PM +0200, Adrian Bunk wrote:
| > 
| >>The following patch lets FireWire support automatically select 
| >>Networking support:
| > 
| > 
| > And so we get another fscking symbol which has a non-obvious way to
| > turn it off.
| > 
| 
| Is it possible to make xconfig and menuconfig show what has an option selected?

It's possible to "Show all options" and several other gui options
in xconfig.  I don't know of similar options in menuconfig.

The xconfig options are useful for debugging where options are
defined, what controls them, etc.

--
~Randy
