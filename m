Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266292AbUITLni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUITLni (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUITLnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:43:37 -0400
Received: from mail.convergence.de ([212.227.36.84]:53638 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S266292AbUITLne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:43:34 -0400
Message-ID: <414EC236.3040206@linuxtv.org>
Date: Mon, 20 Sep 2004 13:42:46 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6][0/14] DVB subsystem update
References: <414AF2CA.3000502@linuxtv.org> <20040917164135.7951c6d9.akpm@osdl.org>
In-Reply-To: <20040917164135.7951c6d9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18.09.2004 01:41, Andrew Morton wrote:
> I'm getting lots of rejects from these.  At the fifth patch I gave up.  The
> rejects appear to be against stock 2.6.9-rc2.

The patchset was against 2.6.8(.1), the rejects come from the janitor 
cleanups for msleep() in the saa7146 driver and from the 
sys_read()/errno mess in the frontend drivers, which loaded the firmware 
directly.

> Please regenerate these patches and double-check that they apply to latest
> -linus tree.  Or against next -mm if they are dependent upon Gerd's
> patches:

I'll send you a new patchset against 2.6.9-rc2-mm1 in private right now. 
  The patches have been adopted or re-generated to fit against your 
latest tree, so I don't post them in public any more.

CU
Michael.
