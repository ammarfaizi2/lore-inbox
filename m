Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWCHBxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWCHBxo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbWCHBxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:53:44 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:55733 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751509AbWCHBxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:53:43 -0500
From: Grant Coady <gcoady@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm3
Date: Wed, 08 Mar 2006 12:53:32 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <k1es029t4h08u3gcl00ie9q0qic8tu1fu4@4ax.com>
References: <20060307021929.754329c9.akpm@osdl.org>
In-Reply-To: <20060307021929.754329c9.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2006 02:19:29 -0800, Andrew Morton <akpm@osdl.org> wrote:

>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/
>
>- A relatively small number of changes, although we're up to 9MB of diff
>  in the various git trees.

Hi there,

-mm3 failed to boot on sempro box[1], after lilo, screen went blank, 
no response... hit reset to reboot...  Same config as -mm2 which did 
boot okay.

Applying "revert-x86_64-mm-i386-early-alignment.patch" fixed it here too.
(CPU is Sempron SktA 32-bit)

[1] http://bugsplatter.mine.nu/test/linux-2.6/sempro/ for dmesg & config
from -mm2

Grant.
