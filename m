Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUGAR0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUGAR0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 13:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266197AbUGAR0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 13:26:46 -0400
Received: from p02m166.mxlogic.net ([216.173.230.166]:7305 "HELO
	p02m166.mxlogic.net") by vger.kernel.org with SMTP id S266196AbUGAR0j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 13:26:39 -0400
From: Michael Driscoll <fenris@ulfheim.net>
Organization: FFW/CO
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [OT] Testing PROT_NONE and other protections, and a surprise
Date: Thu, 1 Jul 2004 11:26:11 -0600
User-Agent: KMail/1.6.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040701123941.GC4187@mail.shareable.org> <F64265B6-CB6C-11D8-947A-000393ACC76E@mac.com>
In-Reply-To: <F64265B6-CB6C-11D8-947A-000393ACC76E@mac.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407011126.11159.fenris@ulfheim.net>
X-OriginalArrivalTime: 01 Jul 2004 17:26:37.0905 (UTC) FILETIME=[90985C10:01C45F90]
X-MX-Spam: exempt
X-MX-MAIL-FROM: <fenris@ulfheim.net>
X-MX-SOURCE-IP: [63.78.248.11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 July 2004 08:43, Kyle Moffett wrote:
> On Jul 01, 2004, at 08:39, Jamie Lokier wrote:
> > The error code is -1, aka. MAP_FAILED.
>
> Oops!  I guess I was just lucky that part didn't fail :-D  On the other
> hand, it couldn't legally return 0 anyway, could it?  That would have been a
> slightly more sensible error code, IMHO, anyway, but it probably came from
> some silly standard somewhere.

mmap can (and will, in the case of glibc) return NULL for a length of 0.

-- 
Michael Driscoll, fenris@ulfheim.net
"A noble spirit embiggens the smallest man" -- J. Springfield
