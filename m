Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTIVQHq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbTIVQHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:07:46 -0400
Received: from speech.linux-speakup.org ([129.100.109.30]:45710 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id S261376AbTIVQHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 12:07:45 -0400
From: Kirk Reiser <kirk@braille.uwo.ca>
To: linux-kernel@vger.kernel.org
Subject: unknown symbols loading modules under 2.6.x
Message-Id: <E1A1TE1-00075s-00@speech.braille.uwo.ca>
Date: Mon, 22 Sep 2003 12:07:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone:  I have been trying to hunt down the answer to
aproblem I am having attempting to load my modules under the 2.6.x
kernels.  They load just fine under the 2.4.x kernels.  Have there
been changes which need to be made to get symbols found with modprobe
other than the EXPORT_SYMBOL() macro?  The symbols show up in the
modules.symbols file created by depmod.  They appear to reference the
correct loadable module.  The loadable module these symbols are
exported in however is comprised of two separate .o files during
compile.  I am not sure whether that has anything to do with it or
not.

If someone could give me an idea what to read to solve this I'd
appreciate it.

  Kirk
