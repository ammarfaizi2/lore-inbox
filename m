Return-Path: <linux-kernel-owner+w=401wt.eu-S968848AbWLHUID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968848AbWLHUID (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 15:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968846AbWLHUIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 15:08:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:57635 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968842AbWLHUH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 15:07:59 -0500
From: Andi Kleen <ak@suse.de>
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: What was in the x86 merge for .20
Date: Fri, 8 Dec 2006 21:07:54 +0100
User-Agent: KMail/1.9.5
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, linux-kernel@vger.kernel.org
References: <200612080401.25746.ak@suse.de> <200612081904.33205.ak@suse.de> <200612081910.39684.arekm@maven.pl>
In-Reply-To: <200612081910.39684.arekm@maven.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612082107.54987.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> binutils-2.17.50.0.8-1.i686
> gcc-4.2.0-0.20061206r119598.2.i686

Hmm, that's not even a release -- afaik gcc 4.2 isn't out yet.

Can you please do

make arch/i386/math-emu/fpu_entry.i
make arch/i386/math-emu/fpu_entry.s

and send me the resulting .i and .s files privately? 

-Andi
