Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265103AbTFCQxx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbTFCQxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:53:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:54662 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S265103AbTFCQxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:53:21 -0400
Date: Tue, 3 Jun 2003 14:04:44 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-rc7
Message-ID: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo,

Now I really hope its the last one, all this rc's are making me mad.

Ok, here it is.


Summary of changes from v2.4.21-rc6 to v2.4.21-rc7
============================================

<ehabkost@conectiva.com.br>:
  o [SPARC]: Export phys_base on sparc32

<jgarzik@pobox.com>:
  o fix olympic driver build

<lethal@linux-sh.org>:
  o Fix Solution Engine 7751 Build
  o Define VM_DATA_DEFAULT_FLAGS for SH

<wesolows@foobazco.org>:
  o [sparc]: Attempt mul/div emulation handling on all cpus

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC]: Fix sys_ipc to return ENOSYS instead of EINVAL as appropriate
  o [SPARC64]: Implement dump_stack in 2.4.x
  o [SPARC64]: Only use power interrupt when button property exists
  o [IPV4/IPV6]: Use Jenkins hash for fragment reassembly handling
  o [IPV6]: Input full addresses into TCP_SYNQ hash function
  o [IPV4]: Add sysctl to control ipfrag_secret_interval
  o [SPARC64]: Fix probe error handling in envctrl.c driver
  o [SPARC64]: Fix probe error handling in bbc_{envctrl,i2c}.c driver
  o [SPARC64]: Fix exploitable holes and bugs in ioctl32 translations

Douglas Gilbert <dougg@torque.net>:
  o sg: Fix side effect introduced by last "off by one" fix

Eric Brower <ebrower@usa.net>:
  o [SPARC]: Refactor AUXIO support

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -rc7

Pete Zaitcev <zaitcev@redhat.com>:
  o [sparc] Force type in __put_user
  o [SPARC]: Fix gcc-3.x builds

Rob Radez <rob@osinvestor.com>:
  o [sparc]: Fix uninitialized spinlock in SRMMU code
  o [SPARC]: Kill initialize_secondary, unused

