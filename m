Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131549AbQKQAKb>; Thu, 16 Nov 2000 19:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131557AbQKQAKW>; Thu, 16 Nov 2000 19:10:22 -0500
Received: from vega.services.brown.edu ([128.148.19.202]:55701 "EHLO
	vega.brown.edu") by vger.kernel.org with ESMTP id <S131549AbQKQAKG>;
	Thu, 16 Nov 2000 19:10:06 -0500
Message-Id: <4.3.2.7.2.20001116184203.00b45100@postoffice.brown.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 16 Nov 2000 18:43:20 -0500
To: linux-kernel@vger.kernel.org
From: David Feuer <David_Feuer@brown.edu>
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <Pine.GSO.4.21.0011161801380.13047-100000@weyl.math.psu.edu
 >
In-Reply-To: <8v1ng9$omi$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:10 PM 11/16/2000 -0500, you wrote:
>Here's one more: you can't rename across the binding boundary. They _are_
>mounts, so they avoid all that crap with loop creation on rename, etc.
>Take a generic DAG and try to implement rename() analog on it. Have fun
>catching the cases that would make the graph disconnected.

How could the graph become disconnected?  What does connectedness have to 
do with naming?

--
This message has been brought to you by the letter alpha and the number pi.
Open Source: Think locally, act globally.
David Feuer
David_Feuer@brown.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
