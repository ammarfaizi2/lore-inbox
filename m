Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267309AbTAKRzq>; Sat, 11 Jan 2003 12:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267318AbTAKRzq>; Sat, 11 Jan 2003 12:55:46 -0500
Received: from packet.digeo.com ([12.110.80.53]:24220 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267309AbTAKRzq> convert rfc822-to-8bit;
	Sat, 11 Jan 2003 12:55:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Morton <akpm@digeo.com>
To: Kees Bakker <kees.bakker@xs4all.nl>, Kees Bakker <rnews@altium.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.55 - buffer layer error at fs/buffer.c:1182
Date: Sat, 11 Jan 2003 10:04:39 -0800
User-Agent: KMail/1.4.3
References: <15904.13029.539865.117389@iris.hendrikweg.doorn>
In-Reply-To: <15904.13029.539865.117389@iris.hendrikweg.doorn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301111004.39829.akpm@digeo.com>
X-OriginalArrivalTime: 11 Jan 2003 18:04:25.0865 (UTC) FILETIME=[E093D790:01C2B99B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat January 11 2003 07:06, Kees Bakker wrote:
>
> Here is the call trace:
> buffer layer error at fs/buffer.c:1182
> ...
> Is this the same as the problem reported by Jordan Breeding?

Yes, that's the htree double-brelse-bug.

Ho-hum.  I don't know diddly about the htree code, and it's written in
C-for-Martians.  But I'll see if I can work out what it's doing.


