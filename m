Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTJHWev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 18:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbTJHWev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 18:34:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34320 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261812AbTJHWeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 18:34:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: devfs and udev
Date: 8 Oct 2003 15:34:29 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bm23dl$a99$1@cesium.transmeta.com>
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com> <Pine.LNX.4.58.0310071354580.19220@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.58.0310071354580.19220@dlang.diginsite.com>
By author:    David Lang <david.lang@digitalinsight.com>
In newsgroup: linux.dev.kernel
> 
> the namespace was different becouse Linus demanded that it be different,
> origionally it had a mode where it would generate all the same names (and
> another mode that generated sun style names) one of the requirements
> before it was put in was to change it to the existing devfs-only names.
> 
> blame devfs for a lot of things (bugs, etc) but not the names.
> 

Actually, this is bullshit.  If you go back and look what Linus
actually said, it was:

- One namespace only.  If you're going to a new namespace, then that's
  going to be it.  You're not going to put two namespaces in the
  kernel.

- If you're going hierarcial, do it right, not the Sun-like halfassed
  thing.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
