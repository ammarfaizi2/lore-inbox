Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSGFFdT>; Sat, 6 Jul 2002 01:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSGFFdS>; Sat, 6 Jul 2002 01:33:18 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:16653 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317616AbSGFFdS>;
	Sat, 6 Jul 2002 01:33:18 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207060535.g665ZWs133693@saturn.cs.uml.edu>
Subject: Re: linux 2.5.25
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 6 Jul 2002 01:35:32 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33.0207051646280.2484-100000@penguin.transmeta.com> from "Linus Torvalds" at Jul 05, 2002 04:54:20 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Right now the x86 timer frequency is set to 1kHz, but that's just another 
> random number. It could be a config option if people really care, but I'd 
> rather just have people argue for or against specific internal frequencies 
> and we'll find something most people are happy with. It's easy to change 
> without user space even noticing now.

You could go by the CPU choice that already exists:

386      -->  100
486      -->  200
Pentium  -->  400
PPro     -->  800
P-III,P4 --> 1600
