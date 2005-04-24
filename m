Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVDXNCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVDXNCm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 09:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVDXNCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 09:02:42 -0400
Received: from mail.aei.ca ([206.123.6.14]:6120 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262326AbVDXNCj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 09:02:39 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Alexander Nyberg <alexn@dsv.su.se>
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
Date: Sun, 24 Apr 2005 09:03:30 -0400
User-Agent: KMail/1.7.2
Cc: Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org,
       ak@suse.de
References: <200504240008.35435.kernel-stuff@comcast.net> <1114332119.916.1.camel@localhost.localdomain>
In-Reply-To: <1114332119.916.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504240903.31377.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 April 2005 04:41, Alexander Nyberg wrote:
> sön 2005-04-24 klockan 00:08 -0400 skrev Parag Warudkar:
> > While running a 32 bit Java program 2.6.12-rc3 rebooted spontaneously leaving 
> > a corrupt partition table and disk with errors. There was nothing in dmesg 
> > (no oops/panic) except some -MARK- entries during the reboot.
> > 
> 
> Is this reproducible? If so, can you give a detailed description of how.

I think rc3 has code from rc2-mm2/3.  Both of these reboot here randomly.  Nothing
shows up on a serial console...  Think something is seriously wrong with x86_64 in rc3.
That being said its possible its fixed in HEAD by.

[PATCH] x86_64: fix new out of line put_user()
[PATCH] x86_64: Bug in new out of line put_user()

some people have reported reversing (in -mm)

sched-unlocked-context-switches.patch

Helps too.

Ed Tomlinson
