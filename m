Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269944AbRHQI5B>; Fri, 17 Aug 2001 04:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269981AbRHQI4x>; Fri, 17 Aug 2001 04:56:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9484 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269944AbRHQI4i>; Fri, 17 Aug 2001 04:56:38 -0400
Subject: Re: 2.4.9 does not compile
To: adam@yggdrasil.com (Adam J. Richter)
Date: Fri, 17 Aug 2001 09:58:42 +0100 (BST)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Adam J. Richter" at Aug 16, 2001 10:03:07 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XfSk-0006wu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	If you really want this facility, you could just declare
> a distinct "typed_min" macro.

For -ac I intend to change it to exactly that. Then we can also back
propogate compatibility macros. Abusing min prevents that
