Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbVKJOCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVKJOCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbVKJOBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:01:53 -0500
Received: from cantor.suse.de ([195.135.220.2]:44749 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750902AbVKJOBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:01:18 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH 19/39] NLKD/x86-64 - stack-pointer-invalid markers
Date: Thu, 10 Nov 2005 14:23:55 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43720DAE.76F0.0078.0@novell.com> <4372120B.76F0.0078.0@novell.com> <43721239.76F0.0078.0@novell.com>
In-Reply-To: <43721239.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101423.55768.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 November 2005 15:14, Jan Beulich wrote:
> This adds static information about the code regions where the stack
> pointer cannot be relied upon. Kernel debuggers may then use this
> information to determine which stack to switch to when having a need
> to switch off of namely the NMI stack.

Hmm - can't this be expressed in CFI somehow? 

-Andi
