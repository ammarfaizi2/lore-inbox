Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316747AbSE3P3m>; Thu, 30 May 2002 11:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSE3P3l>; Thu, 30 May 2002 11:29:41 -0400
Received: from knatte.nada.kth.se ([130.237.226.102]:26054 "EHLO
	knatte.nada.kth.se") by vger.kernel.org with ESMTP
	id <S316747AbSE3P3l>; Thu, 30 May 2002 11:29:41 -0400
Date: Thu, 30 May 2002 17:29:40 +0200 (MEST)
Message-Id: <200205301529.RAA09965@knatte.nada.kth.se>
From: "=?ISO-8859-1?Q?Bj=F6rn Antonsson?=" <d93-ban@nada.kth.se>
To: linux-kernel@vger.kernel.org
Cc: d93-ban@nada.kth.se
Subject: How do you detect that hyperthreading is activated?
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have an application that needs to check if a linux kernel has booted
with hyperthreading enabled on ia32, in order to do some special tweaks.
I know how you detect that a CPU supports hyperthreading, but how do you
detect that the kernel has booted with hyperthreading activated?

And by hyperthreading activated I mean that the current number of CPUs,
for example 8, are actually 4 physical CPUs and 4 logical CPUs.

Is there a way that I can get at the logical/physical CPU bits, as
reported by the CPUID instruction, of all available CPUs? Or is there
an even better way?

/Björn
