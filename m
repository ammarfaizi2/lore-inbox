Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267020AbSLKFKz>; Wed, 11 Dec 2002 00:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267022AbSLKFKz>; Wed, 11 Dec 2002 00:10:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:5834 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267020AbSLKFKy>;
	Wed, 11 Dec 2002 00:10:54 -0500
Message-ID: <3DF6CAA9.BC34612@digeo.com>
Date: Tue, 10 Dec 2002 21:18:33 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Wil Reichert <wilreichert@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: "bio too big" error
References: <3DF6A673.D406BC7F@digeo.com> <1039577938.388.9.camel@darwin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Dec 2002 05:18:33.0660 (UTC) FILETIME=[C01F8FC0:01C2A0D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wil Reichert wrote:
> 
> Exact error with debug is:
> 
> darwin:/a01/mp3s/Skinny Puppy/Too Dark Park# ogg123 -q 01\ -\
> Convulsion.ogg
> bio too big device ide0(3,4) (256 > 255)
> Call Trace: [<c020055e>]  [<e09ff46d>]  [<e09ff558>]  [<e09ff5f5>]
> [<c020050a>]  [<c02005f4>]  [<c017048e>]  [<c0170a79>]  [<c0187770>]
> [<c01472e6>]  [<c0187770>]  [<c0140edd>]  [<c01977fc>]  [<c01473e4>]
> [<c01475be>]  [<c0137ac8>]  [<c0137e60>]  [<c0138124>]  [<c0137e60>]
> [<c01381ca>]  [<c014eadb>]  [<c01094cb>]
> [<e09def98>]  [<c01113bf>]  [<c0110ac2>]  [<c014ebce>]  [<c014ee6e>]
> [<c010967f>]
> 

Could you please enable CONFIG_KALLSYMS and regenerate the backtrace?

Thanks.
