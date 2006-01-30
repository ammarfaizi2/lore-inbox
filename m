Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWA3S1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWA3S1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWA3S1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:27:39 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:38662 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751285AbWA3S1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:27:39 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ken MacFerrin <lists@macferrin.com>
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
Date: Mon, 30 Jan 2006 16:46:53 +0000
User-Agent: KMail/1.9
Cc: Jesper Juhl <jesper.juhl@gmail.com>, hugh@veritas.com,
       linux-kernel@vger.kernel.org
References: <43DAE307.5010306@macferrin.com> <43DD3DDF.6020901@macferrin.com> <43DD644B.8070501@macferrin.com>
In-Reply-To: <43DD644B.8070501@macferrin.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601301646.53526.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 00:56, Ken MacFerrin wrote:
[snip]
> Unfortunately it seems that the "nv" driver in Xorg does not currently
> support multiple displays on a single video card with dual heads.  Not
> being able to at least run xinerama is a deal breaker for me so I'm back
> to the binary nvidia driver using twinview.  At this point I will apply
> Hugh's patch and post any further "Bad page state" and "Bad rmap"
> messages as instructed.

Indeed, Hugh's patch is the best way to proceed with discovering who the 
culprits are. Using the "nv" driver was not really meant as a debugging aide, 
but as a last resort if the patch yields nothing useful.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
