Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbUCRNGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 08:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbUCRNGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 08:06:00 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:59654 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S262599AbUCRNF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 08:05:59 -0500
Date: Thu, 18 Mar 2004 14:06:40 +0100
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: Remove kernel features (for embedded systems)
Message-ID: <20040318130640.GA28923@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I propose to add the following kernel features to the removables:

  * /dev/kmem and /proc/kcore
  * core dumping
  * ptrace

And if it is at all possible, I would like to be able to remove parts of
the IP stack, e.g. routing.  In particular, I would like to be able to
remove policy routing, if it is at all worth it from the code size point
of view.

Removing ptrace and kmem is mostly for security reasons, but being able
to remove them makes sense in embedded environments as well.

Felix
