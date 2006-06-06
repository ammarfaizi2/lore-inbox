Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWFFJfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWFFJfA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 05:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWFFJfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 05:35:00 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:52937 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S932134AbWFFJe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 05:34:59 -0400
Date: Tue, 6 Jun 2006 11:34:56 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: AMD64: 64 bit kernel 32 bit userland - some pending questions
Message-ID: <20060606093456.GL4552@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,
I would like to use an AMD64 Opteron System with a 64 bit Linux Kernel,
but a 32 bit userland (Debian Sarge). I have a few questions about this:

        - Is it possible to give the userland 3Gbyte virtual address
          space (default for 2.4 and 2.6). But give the Kernel a 64 bit
          virtual address space so that I get more than 1 Gbyte physical
          Memory into LOWMEM - say I want 8 Gbyte - without using HIGHMEM
          at all? If this scenario is possible I would get cheap memory
          access at the benefit of a well tested userland. I don't have
          applications that need more than 2 Gbyte virtual address
          space.

        - What is the easiest way to build a 64 bit kernel on a 32 bit
          Debian sarge. Are there crosscompiler packages available? Are
          there any guides on this?

        - If the above scenario works out like I imagine it, does this
          add some additional overhead I am not aware of when I switch
          for example from 32 bit userland to 64 bit kernel space which
          would override the performance gain I get from the huge LOWMEM
          virtuall address space?

        Thomas
