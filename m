Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130751AbQLEKm3>; Tue, 5 Dec 2000 05:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130874AbQLEKmU>; Tue, 5 Dec 2000 05:42:20 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:4596 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S130751AbQLEKmN>;
	Tue, 5 Dec 2000 05:42:13 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.SOL.4.30.0012042358270.19766-100000@stellar.cso.uiuc.edu> 
In-Reply-To: <Pine.SOL.4.30.0012042358270.19766-100000@stellar.cso.uiuc.edu> 
To: Andrew Reitz <areitz@uiuc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Assistance requested in demystifying wait queues. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Dec 2000 10:11:35 +0000
Message-ID: <17225.976011095@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


areitz@uiuc.edu said:
>  I have managed to draw the following skeleton from the kHTTPd source

Don't look at that code. It uses sleep_on(), therefore is probably broken.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
