Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293458AbSCOXDz>; Fri, 15 Mar 2002 18:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293465AbSCOXDr>; Fri, 15 Mar 2002 18:03:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17938 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293458AbSCOXDc>; Fri, 15 Mar 2002 18:03:32 -0500
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
To: davids@webmaster.com (David Schwartz)
Date: Fri, 15 Mar 2002 23:19:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020315223649.AAA27488@shell.webmaster.com@whenever> from "David Schwartz" at Mar 15, 2002 02:36:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16m0yp-0004y8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	My interest for this is mostly for Zebra to be able to make secure BGP 
> connections, so I would also contribute a patch for Zebra to support this 
> feature on Linux.

For minimal versions of secure ?

    Since this memo was first issued (under a different title), the MD5
    algorithm has been found to be vulnerable to collision search attacks
    [Dobb], and is considered by some to be insufficiently strong for
    this type of application.

You'll also find that with SACK it doesn't fit in the tcp header..

