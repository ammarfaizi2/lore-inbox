Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131057AbRAGMMd>; Sun, 7 Jan 2001 07:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131146AbRAGMMY>; Sun, 7 Jan 2001 07:12:24 -0500
Received: from james.kalifornia.com ([208.179.0.2]:33643 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131057AbRAGMMM>; Sun, 7 Jan 2001 07:12:12 -0500
Date: Sun, 7 Jan 2001 04:11:40 -0800 (PST)
From: David Ford <david+nospam@killerlabs.com>
Reply-To: David Ford <david+validemail@killerlabs.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Russell King <rmk@arm.linux.org.uk>,
        Nicolas Noble <Pixel@the-babel-tower.nobis.phear.org>,
        "Linux-kernel's Mailing list" <linux-kernel@vger.kernel.org>
Subject: Re: Little question about modules... 
In-Reply-To: <31837.978868303@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.10.10101070410310.4173-100000@Huntington-Beach.Blue-Labs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Keith Owens wrote:
>   If the module controls its own unloading via a can_unload routine
>   then the user count displayed by lsmod is always -1, irrespective of
>   the real use count.

Maybe lsmod can show a blank for the field and (auto unload).  That'd
probably draw a lot less "my module is broken" reports.

-d


--
---NOTICE--- fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
