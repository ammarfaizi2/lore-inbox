Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264918AbUD3TXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbUD3TXF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUD3TXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:23:04 -0400
Received: from zero.aec.at ([193.170.194.10]:23565 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264918AbUD3TXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:23:02 -0400
To: Michael Brown <mebrown@michaels-house.net>
Subject: Re: [PATCH 2.4] add SMBIOS information to /proc/smbios -- UPDATED
References: <1QvX0-A4-29@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Date: Fri, 30 Apr 2004 21:22:51 +0200
In-Reply-To: <1QvX0-A4-29@gated-at.bofh.it> (Michael Brown's message of
 "Fri, 30 Apr 2004 04:30:14 +0200")
Message-ID: <m3r7u59sok.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Brown <mebrown@michaels-house.net> writes:

> 	Below is an updated patch to add SMBIOS information to /proc/smbios.
> Updates have been made per Al's previous comments. Please apply.

What is this good for? There are tools to read this from
/dev/mem; and that is fine because the information is static.
There is no reason to bloat the kernel with this.

-Andi

