Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965771AbWKEBIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965771AbWKEBIa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 20:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965772AbWKEBIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 20:08:30 -0500
Received: from mx1.suse.de ([195.135.220.2]:51665 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965771AbWKEBI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 20:08:29 -0500
From: Andi Kleen <ak@suse.de>
To: "Ulrich Drepper" <drepper@gmail.com>
Subject: Re: [PATCH] conditionalize some x86-64 options
Date: Sun, 5 Nov 2006 02:08:23 +0100
User-Agent: KMail/1.9.5
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
References: <a36005b50611041624x1b9f2602h8d5b90b3337953e2@mail.gmail.com>
In-Reply-To: <a36005b50611041624x1b9f2602h8d5b90b3337953e2@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611050208.23814.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 November 2006 01:24, Ulrich Drepper wrote:
> Shouldn't the X86_MCE{INTEL,AMD} option depend on the other
> manufacturer's CPU not being explicitly selected?

No -- the CPU selection on x86-64 means "optimize for", but doesn't 
mean don't run on other CPUs.

-Andi
