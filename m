Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136189AbRDVP7W>; Sun, 22 Apr 2001 11:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136190AbRDVP7M>; Sun, 22 Apr 2001 11:59:12 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:33034 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S136189AbRDVP64>;
	Sun, 22 Apr 2001 11:58:56 -0400
To: Daniel Dorau <woodst@cs.tu-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Inspiron 8000 does not resume after suspend
In-Reply-To: <20010421145133.A419@woodstock.home.xxx>
From: Jes Sorensen <jes@linuxcare.com>
Date: 22 Apr 2001 17:58:48 +0200
In-Reply-To: Daniel Dorau's message of "Sat, 21 Apr 2001 14:51:33 +0200"
Message-ID: <d3elul0vuv.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Daniel" == Daniel Dorau <woodst@cs.tu-berlin.de> writes:

Daniel> Hello, my Inspiron 8000 (BIOS A09) notebook running 2.4.3 does
Daniel> not resume after suspending. I have APM compiled in with the
Daniel> following options:

Daniel> - Enable PM at boot time - Make CPU Idle calls whe ide -
Daniel> Enable console blanking using APM - RTC stores time in GMT

This sounds a little like the problem I am seeing with my
StinkPad 600E, you might want to try enabling CONFIG_APM_ALLOW_INTS
and see if that makes a difference (thats the magic option required
for the 600E).

Jes
