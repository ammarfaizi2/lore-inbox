Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWFUJUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWFUJUg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbWFUJUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:20:36 -0400
Received: from mail.suse.de ([195.135.220.2]:64447 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751444AbWFUJUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:20:35 -0400
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] i386: halt the CPU on serious errors
References: <200606200059_MC3-1-C2E8-8C46@compuserve.com>
From: Andi Kleen <ak@suse.de>
Date: 21 Jun 2006 11:20:34 +0200
In-Reply-To: <200606200059_MC3-1-C2E8-8C46@compuserve.com>
Message-ID: <p73d5d2q2zh.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> writes:

> Halt the CPU when serious errors are encountered and we
> deliberately go into an infinite loop.

You need to check first if the CPU supports halt. 

-Andi
