Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293452AbSCOXAg>; Fri, 15 Mar 2002 18:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293457AbSCOXAZ>; Fri, 15 Mar 2002 18:00:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12050 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293452AbSCOXAN>; Fri, 15 Mar 2002 18:00:13 -0500
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
To: davem@redhat.com (David S. Miller)
Date: Fri, 15 Mar 2002 23:15:56 +0000 (GMT)
Cc: davids@webmaster.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020315.145306.15914579.davem@redhat.com> from "David S. Miller" at Mar 15, 2002 02:53:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16m0vU-0004xU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And if people want encryption they can use ipsec.  And if
> ipsec is broken it should be fixed because adding a new
> abomination to MD5.
> 
> Maybe I'm missing something, but I see no reason this MD5
> stuff belongs in the protocol and not in the APP.

Not only that MD5 shouldn't be the one. The crypto folks prefer SHA and for
good reasons.
