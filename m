Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbULaJp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbULaJp5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 04:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbULaJp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 04:45:57 -0500
Received: from 1-1-8-31a.gmt.gbg.bostream.se ([82.182.75.118]:45804 "EHLO
	mail.shipmail.org") by vger.kernel.org with ESMTP id S261827AbULaJpv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 04:45:51 -0500
Message-ID: <41D52153.3000307@shipmail.org>
Date: Fri, 31 Dec 2004 10:52:19 +0100
From: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <unichrome@shipmail.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6)
 Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@linux.ie>
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
Subject: Re: VIA drm bk tree back up...
References: <Pine.LNX.4.58.0412310502200.24852@skynet>
In-Reply-To: <Pine.LNX.4.58.0412310502200.24852@skynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-BitDefender-Spam: No (0)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dave Airlie wrote:

>Okay I've rebuilt the via drm tree (bk://drm.bkbits.net/drm-via)
>
>It should work but I've no way to test it, I think the drm is close to
>secure now if not already, and if I get the nod from the people who know
>these things (Thomas, Erdi and Keith - consider yourselves the people),
>I'll try and have it included in 2.6.11
>
>Dave.
>
>  
>
The status of the VIA drm is as follows, AFAICT:

1. I would consider it secure. I have a minor update coming in in a day 
or so.
2. The command verifier sometimes reject 3D command streams that should 
not be rejected. Some work to fix but cannot be done immediately (at 
least not by me.)
3. The AGP ring-buffer could hang under heavy 3D load. Without input 
from VIA I believe this is hard to fix.

/Thomas




