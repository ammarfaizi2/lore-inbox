Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWJKTyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWJKTyQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWJKTyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:54:16 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:33109 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932473AbWJKTyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:54:15 -0400
Message-ID: <452D4BE2.6070202@tls.msk.ru>
Date: Wed, 11 Oct 2006 23:54:10 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SOT] GIT usage question
References: <452D3DFA.6010408@tls.msk.ru> <20061011192921.GA8345@electric-eye.fr.zoreil.com>
In-Reply-To: <20061011192921.GA8345@electric-eye.fr.zoreil.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Michael Tokarev <mjt@tls.msk.ru> :
> [...]
>> Is it possible?
> 
> git diff 2.6.18..origin -- drivers/ata ?

Yeah, -- the idea is to identify which changes are relevant
using some other criteria, not "git tree placement" or something
like that -- example is to use directory as you suggested (plus
relevant includes).

> Experiment with options for rename.

Yeah -- like git-diff-tree -M, I used it before (for this libata stuff
as well), and even wrote a tiny shell wrapper around patch(1) to
apply git-diff-tree -M -generated patch - first pass is to handle
renames in shell, and second pass is to apply the patch itself... ;)

Thanks.

/mjt
