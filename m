Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbUJ0UPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbUJ0UPk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbUJ0UOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:14:07 -0400
Received: from siaag2ag.compuserve.com ([149.174.40.140]:8581 "EHLO
	siaag2ag.compuserve.com") by vger.kernel.org with ESMTP
	id S262632AbUJ0TzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:55:07 -0400
Date: Wed, 27 Oct 2004 15:50:29 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Let's make a small change to the process
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Randy Dunlap <rddunlap@osdl.org>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Message-ID: <200410271553_MC3-1-8D4F-38E8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004 at 16:05 +0100 Alan Cos wrote:

> Each 2.6.10rc change I merged is on the basis of reward >> risk.

  I'm inclined to even accept very small patches that aren't really
bugfixes, like initmem poisoning and the signal delivery patch
that removes unconditional writes to dr7.

  But some of the larger ones scare me, especially when they need
modification to apply cleanly.  Even if the mods are clear, there
can be new logic elsewhere that breaks a backported patch.


--Chuck Ebbert  27-Oct-04  15:49:15
