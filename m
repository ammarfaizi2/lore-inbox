Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266217AbUFYIWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUFYIWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 04:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266359AbUFYIWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 04:22:48 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:26384 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S266217AbUFYIWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 04:22:45 -0400
Date: Fri, 25 Jun 2004 10:22:43 +0200
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: 2.6.7-mm2, mmaps rework, buggy apps, setarch
Message-ID: <20040625082243.GA11515@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list, hi Andrew!

You wrote:
> Added a patch from Ingo which reworks the placement of mmaps within the
> ia32 virtual memory layout.  Has been in RH kernels for a long time.
>
>  If it breaks something, the app was already buggy.  You can use
>
>	setarch -L my-buggy-app <args>
>
> to run in back-compat mode.  This requires a setarch patch - see the
> changelog in flexible-mmap-267-mm1-a0.patch for details.

Can someone please explain me *what* the effects of a `buggy app' would
be: Segfault I suppose. But what to do with a commerical app where I
cannot check a stack trace or whatever?

Background: I am having problems with current debian/sid on 2.6.7-mm2
with vuescan.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
STURRY (n.,vb.)
A token run. Pedestrians who have chosen to cross a road immediately
in front of an approaching vehicle generally give a little wave and
break into a sturry. This gives the impression of hurrying without
having any practical effect on their speed whatsoever.
			--- Douglas Adams, The Meaning of Liff
