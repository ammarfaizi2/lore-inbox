Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbVK3T3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbVK3T3I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 14:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbVK3T3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 14:29:08 -0500
Received: from CPE-24-31-244-49.kc.res.rr.com ([24.31.244.49]:11668 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1751513AbVK3T3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 14:29:07 -0500
From: Luke-Jr <luke-jr@utopios.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.x] prevent emulated SCSI hosts from wasting DMA memory
Date: Wed, 30 Nov 2005 19:33:47 +0000
User-Agent: KMail/1.9
References: <20051130171520.GB15505@localdomain>
In-Reply-To: <20051130171520.GB15505@localdomain>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511301933.48668.luke-jr@utopios.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 November 2005 17:15, Dan Aloni wrote:
> Emulated scsi hosts don't do DMA, so don't unnecessarily increase
> the SCSI DMA pool.

They don't? Recently I learned(?) that apparently using hdparm -d on the 
old /dev/hdX device still worked/applied when using ide-scsi... or do 
"emulated scsi hosts" refer to something else?
-- 
Luke-Jr
Developer, Utopios
http://utopios.org/
