Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVHDRku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVHDRku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 13:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVHDRkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 13:40:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14056 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261487AbVHDRjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 13:39:08 -0400
Date: Thu, 4 Aug 2005 13:38:56 -0400
From: Dave Jones <davej@redhat.com>
To: Rolf Eike Beer <eike@sf-mail.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>,
       linux-scsi@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH 1/2] cpqfc: fix for "Using too much stach" in 2.6 kernel
Message-ID: <20050804173856.GG22886@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rolf Eike Beer <eike@sf-mail.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>,
	linux-scsi@vger.kernel.org, axboe@suse.de
References: <4221C1B21C20854291E185D1243EA8F302623BCC@bgeexc04.asiapacific.cpqcorp.net> <200508041756.23611@bilbo.math.uni-mannheim.de> <20050804164259.GD22886@redhat.com> <200508041911.46911@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508041911.46911@bilbo.math.uni-mannheim.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 07:11:38PM +0200, Rolf Eike Beer wrote:
 > >It's pointless to fix this, without fixing also CpqTsGetSFQEntry()
 > At least half of the file should be rewritten.

Just half ? You're such an optimist :-)

 > > > No, ulDestPtr ist ULONG* so we increase it by sizeof(ULONG)*16 which is
 > > > 64.
 > >Duh, yes.  That is broken on 64-bit however, where it will advance 128 bytes
 > >instead of 64 bytes.
 > 
 > ULONG is defined to __u32 in some of the cpq* headers.

Ewwwww.
Ok, definitly time to stop reading.

		Dave

