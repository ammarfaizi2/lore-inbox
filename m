Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbTBGXYu>; Fri, 7 Feb 2003 18:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbTBGXYt>; Fri, 7 Feb 2003 18:24:49 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:45473 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S266810AbTBGXYt>; Fri, 7 Feb 2003 18:24:49 -0500
Message-Id: <5.1.0.14.2.20030207153336.0583e198@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 07 Feb 2003 15:34:22 -0800
To: "David S. Miller" <davem@redhat.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030207.014836.78483470.davem@redhat.com>
References: <Pine.LNX.4.33.0301180439480.10820-100000@champ.qualcomm.com>
 <Pine.LNX.4.33.0301020341140.2038-100000@champ.qualcomm.com>
 <Pine.LNX.4.33.0301180439480.10820-100000@champ.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:48 AM 2/7/2003 -0800, David S. Miller wrote:
>   From: Max Krasnyansky <maxk@qualcomm.com>
>   Date: Sun, 19 Jan 2003 19:22:44 -0800 (PST)
>
>   So here is new patch.
>
>Ok, it generally looks fine, and try_module_get() is cheap enough
>(basically the equivalent of a local-cpu statistic bump plus
>a compare) that I'm not concerned about any added overhead.
>
>And since it is fixing a bug... :-)
Good.

>Just let me discuss some things with Alexey before I apply this.
Sure.

Do you want me to push this stuff to BK where you can pull from ?

Max

