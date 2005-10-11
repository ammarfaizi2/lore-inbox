Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVJKRqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVJKRqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 13:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbVJKRqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 13:46:12 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:21693 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751461AbVJKRqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 13:46:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=lDx6K7Goog4qx8mFE/4su9g9pAfctuRAVQfXEO9bm9JN/SpTMiVJNWKtvqDu0n7pWR1TkO+wY2GcFSSP/kxo+UqCisojULs85NxH73CydnyCBZ38jUWH9tsnhX+YdHXb/zejsimjS5GPVUYV+PPPBEBAEvPr9y10UVdv342/y74=
Date: Tue, 11 Oct 2005 21:55:23 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: kernel-janitors@lists.osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc4-kj1
Message-ID: <20051011175523.GA2367@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.14-rc4-kj1 aka "I ran out of bad ideas" patchset is out. You can
get it from usual place: http://coderock.org/kj/2.6.14-rc4-kj1/

Full shortlog of who did what is also available:
http://coderock.org/kj/2.6.14-rc4-kj1/shortlog

* __nocast patches were reworked to use gfp_t facility. Hmm... subject
  lines were left intact.
* ext3 + CONFIG_QUOTA=n patch was merged and dropped in between.

It's nice to see new people sending small things to our list.

New in this release
-------------------
Aaron Grothe
  Remove unreachable code

Alexey Dobriyan
  Remove select_bits_alloc(), select_bits_free()
  cris: kgdb: remove double_this()

Anton Brondz
  arch/i386/kernel/irq.c: use KERN_*

Felix Oxley
  fs/jffs/intrep.c: 255 is unsigned char

Irwan Djajadi
  pcf8563: remove MOD_INC/DEC_USE_COUNT
  hotkey.c: fix memory leak on exit path

Jerome Pinot
  s/HANGUEL/HANGEUL/

Milind A Choudhary
  kernel/timer.c: use KERN_WARNING

Masoud A Sharbiani
  kernel/audit.o: make size smaller
  hexdigits definition consolidation

Merged
------
sungem_fix_nocast_type_warnings.patch
ns83820_fix_nocast_type_warnings.patch
bond_main_c_fix_nocast_type_warnings.patch

