Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVERPEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVERPEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVERPCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:02:05 -0400
Received: from mail1.kontent.de ([81.88.34.36]:7597 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262265AbVERPAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:00:14 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Max Kellermann <max@duempel.org>
Subject: Re: Detecting link up
Date: Wed, 18 May 2005 17:00:08 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <428B1A60.6030505@inescporto.pt> <20050518134031.53a3243a@phoebee> <20050518143712.GA21883@roonstrasse.net>
In-Reply-To: <20050518143712.GA21883@roonstrasse.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505181700.09269.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 18. Mai 2005 16:37 schrieb Max Kellermann:
> A thought on a related topic:
> 
> When a NIC driver knows that there is no link, why does it even try to
> transmit a packet? It could return immediately with an error code,
> without applications having to wait for a timeout.

That would be a duplication of work. If the driver provides
link detection the network core could check for it.

	Regards
		Oliver
