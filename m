Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbVCJWUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbVCJWUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbVCJWRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:17:45 -0500
Received: from relay.axxeo.de ([213.239.199.237]:9699 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S262831AbVCJWRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:17:18 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PPC64] Allow emulation of mfpvr on ppc64 kernel
Date: Thu, 10 Mar 2005 23:17:03 +0100
User-Agent: KMail/1.7.1
References: <20050310021848.GD30435@localhost.localdomain>
In-Reply-To: <20050310021848.GD30435@localhost.localdomain>
Cc: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503102317.04027.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> Andrew, please apply.
>
> Allow userspace programs on ppc64 to use the (privileged) mfpvr
> instruction to determine the processor type.  At the moment it
> emulates the instruction to provide the real PVR value, though it
> could be made to lie in future if for some reason we wish to restrict
> what CPU features userspace uses.

Why not putting the required information into the AUX table
when executing your ELF programs? I loved this feature in the
ix86 arch.


Regards

Ingo Oeser

