Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVCNVuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVCNVuZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVCNVuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:50:21 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:22467 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262012AbVCNVtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:49:45 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [patch 2.6.11-rc5] Add target debug_kallsyms 
In-reply-to: Your message of "Mon, 14 Mar 2005 22:43:41 BST."
             <20050314214341.GF17925@mars.ravnborg.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Mar 2005 08:49:35 +1100
Message-ID: <31391.1110836975@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 22:43:41 +0100, 
Sam Ravnborg <sam@ravnborg.org> wrote:
>On Sat, Feb 26, 2005 at 09:50:02PM +1100, Keith Owens wrote:
>> Make it easier to generate maps for debugging kallsyms problems.
>> debug_kallsyms is only a debugging target so no help or silent mode.
>> 
>> Signed-off-by: Keith Owens <kaos@ocs.com.au>
>Applied to my kbuild tree.
>I will remove it when we stop see kallsyms reports.

Good luck!  Most of the kallsyms reports are not really kallsyms bugs,
rather they are caused by the kallsyms checking picking up toolchain
problems.

