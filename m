Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318190AbSHIIoo>; Fri, 9 Aug 2002 04:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318193AbSHIIoo>; Fri, 9 Aug 2002 04:44:44 -0400
Received: from daffy.thegoop.com ([206.58.79.242]:37127 "EHLO
	daffy.thegoop.com") by vger.kernel.org with ESMTP
	id <S318190AbSHIIon>; Fri, 9 Aug 2002 04:44:43 -0400
Date: Fri, 9 Aug 2002 01:48:40 -0700
From: David Bronaugh <dbronaugh@linuxboxen.org>
To: linux-kernel@vger.kernel.org
Subject: Patch to enable K6-2 and K6-3 processor optimizations
Message-Id: <20020809014840.4e81fbd3.dbronaugh@linuxboxen.org>
Organization: Independent
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is my first kernel patch, so please go easy on me :)

What it does is conditionally enable -march=k6-2 and -march=k6-3, and provide options for each in the Processor Type and Features menu.

This is conditional on the compiler supporting it; as of this writing only GCC 3.1 does. I compiled this kernel successfully with this patch on my K6-III and am presently running this kernel.

It also enables 3DNow in the case of the K6-III; I wasn't sure if 3DNow might imply the extended Athlon 3DNow instructions, so I only enabled it for the K6-III, which I know supports it.

Anyhow, that's all.

David Bronaugh

ps: This is pretty trivial to apply for other CPUs too; as I understand it several different CPU types gained their own architecture strings with GCC 3.1
