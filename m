Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287003AbSBRVGW>; Mon, 18 Feb 2002 16:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287134AbSBRVGN>; Mon, 18 Feb 2002 16:06:13 -0500
Received: from proj2501.aiss.uic.edu ([131.193.164.90]:34065 "EHLO
	proj2501.aiss.uic.edu") by vger.kernel.org with ESMTP
	id <S287003AbSBRVGB>; Mon, 18 Feb 2002 16:06:01 -0500
Date: Mon, 18 Feb 2002 15:11:44 -0600 (CST)
From: "Barton, Christopher" <cpbarton@uiuc.edu>
X-X-Sender: cpbarton@proj2501.aiss.uic.edu
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, jamal <hadi@cyberus.ca>,
        <kuznet@ms2.inr.ac.ru>, "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.4.18-pre8
In-Reply-To: <Pine.LNX.4.21.0202041743180.14205-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0202181504500.26663-100000@proj2501.aiss.uic.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> pre8: 
> 
> - Kill get_fast_time				(David S. Miller)
>

Is it sufficient to replace get_fast_time with gettimeofday?  This breaks
the NAPI patch...

Thanks a lot!





