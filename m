Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752296AbWFME4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbWFME4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 00:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752297AbWFME4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 00:56:53 -0400
Received: from cantor.suse.de ([195.135.220.2]:29568 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752294AbWFME4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 00:56:53 -0400
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@sgi.com>
Subject: Re: 2.6.16-rc6-mm2
Date: Tue, 13 Jun 2006 06:56:45 +0200
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <7384.1150169326@kao2.melbourne.sgi.com>
In-Reply-To: <7384.1150169326@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606130656.45511.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have previously suggested a lightweight solution that pins a process
> to a cpu 

That is preempt_disable()/preempt_enable() effectively
It's also light weight as much as these things can be.

-Andi (who idly wonders if the P4 designers ever realized what
software wrenches they caused with their performance choices for
some instructions)
