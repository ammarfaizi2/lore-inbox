Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWASJkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWASJkW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWASJkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:40:22 -0500
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:37382 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1750890AbWASJkW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:40:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Out of Memory: Killed process 16498 (java).
Date: Thu, 19 Jan 2006 09:40:19 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C2703555F9F@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Out of Memory: Killed process 16498 (java).
Thread-Index: AcYc29M78xaJAt2sRtmwE/wyJdX18QAABtOQ
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Con Kolivas" <kernel@kolivas.org>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you using scsi? Someone just posted what looks to be a 
> scsi slab leak (Re: 
> scsi cmd slab leak? (Was Re: [ck] Anyone been having OOM 
> killer problems 
> lately?) that causes oom kills. Check your slabinfo for a large 
> scsi_cmd_cache.

Not using scsi.  Using ide and sata. The target for the dd command was
an ide disk.

# cat /proc/slabinfo | grep scsi
scsi_cmd_cache         4      8    448    8    1 : tunables   54   27
0 : slabdata      1      1      0

Is that large?

-- 
Andy, BlueArc Engineering
