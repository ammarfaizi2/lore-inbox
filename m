Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262055AbREMRt1>; Sun, 13 May 2001 13:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262056AbREMRtR>; Sun, 13 May 2001 13:49:17 -0400
Received: from geos.coastside.net ([207.213.212.4]:53708 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S262051AbREMRtE>; Sun, 13 May 2001 13:49:04 -0400
Mime-Version: 1.0
Message-Id: <p05100313b724794d9a66@[207.213.214.37]>
In-Reply-To: <E14yyzd-0006iH-00@the-village.bc.nu>
In-Reply-To: <E14yyzd-0006iH-00@the-village.bc.nu>
Date: Sun, 13 May 2001 10:48:42 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: ENOIOCTLCMD?
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 5:45 PM +0100 2001-05-13, Alan Cox wrote:
>  > What I was arguing (conceptually) is that something like
>>  #define ENOIOCTLCMD ENOTTY
>>  or preferably but more invasively s/ENOIOCTLCMD/ENOTTY/ (mutatis mutandis)
>>
>>  would result in no loss of function. I assert that ENOIOCTLCMD is
>>  redundant, pending a specific counterexample.
>
>On the contrary. I can now no longer force an unsupported response when there
>is a generic routine I dont wish to use

That makes sense. Thanks.
-- 
/Jonathan Lundell.
