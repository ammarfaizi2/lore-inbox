Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUHPVhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUHPVhp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 17:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267963AbUHPVhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 17:37:45 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:35312 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S266341AbUHPVho
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 17:37:44 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Kevin Fox <Kevin.Fox@pnl.gov>, Alan Jenkins <sourcejedi@phonecoop.coop>,
       linux-kernel@vger.kernel.org
Date: Mon, 16 Aug 2004 14:37:10 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: cd burning: kernel / userspace?
In-Reply-To: <20040813001302.GA22879@animx.eu.org>
Message-ID: <Pine.LNX.4.60.0408161356110.14170@dlang.diginsite.com>
References: <41189AA2.3010908@phonecoop.coop> <20040810220528.GA17537@animx.eu.org>
 <1092352000.2408.35.camel@localhost.localdomain> <20040813001302.GA22879@animx.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004, Wakko Warner wrote:

> Date: Thu, 12 Aug 2004 20:13:02 -0400
> From: Wakko Warner <wakko@animx.eu.org>
> To: Kevin Fox <Kevin.Fox@pnl.gov>
> Cc: Alan Jenkins <sourcejedi@phonecoop.coop>, linux-kernel@vger.kernel.org
> Subject: Re: cd burning: kernel / userspace?
> 
>> Why not use an interface similar to tapes? Have different devices for
>> different modes of operation?
>
> IIRC, tapes use 2 devices.  A rewind on close and a norewind on close.  How
> many devices would there be for the various cd burning?

insert track gap on close (track-at-a-time)
fixate disk on close (disk-at-a-time or final track)

I don't know if it's worth trying for a 'do nothing on close' since that 
by definition leaves garbage at the close point so what other modes are 
needed?

David Lang

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
