Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132786AbRDDLDn>; Wed, 4 Apr 2001 07:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132785AbRDDLDe>; Wed, 4 Apr 2001 07:03:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7949 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132786AbRDDLDZ>; Wed, 4 Apr 2001 07:03:25 -0400
Subject: Re: get_pid() : enahancement
To: alad@hss.hns.com
Date: Wed, 4 Apr 2001 12:05:04 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <65256A24.00233ECF.00@sandesh.hss.hns.com> from "alad@hss.hns.com" at Apr 04, 2001 12:00:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kl64-0001i8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was just wondering on the efficiency of get_pid() implemetation... Although
> 'next_safe' concept in this function seems useful but I think we now need a
> robust PID allocator..

get_pid() isnt showing up on kernel profile runs I've seen, and that doesn't
actually suprise me. Its not a normal hot path

