Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271401AbRHOUO1>; Wed, 15 Aug 2001 16:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271404AbRHOUOR>; Wed, 15 Aug 2001 16:14:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2318 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271401AbRHOUOI>; Wed, 15 Aug 2001 16:14:08 -0400
Subject: Re: 2.4.8 Resource leaks + limits
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Date: Wed, 15 Aug 2001 21:15:22 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), mag@fbab.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010815215723.F9870@nightmaster.csn.tu-chemnitz.de> from "Ingo Oeser" at Aug 15, 2001 09:57:23 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15X74U-0003va-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not really. Large installations use ACLs instead of groups. 

Umm you can't use ACL's for resource management. You have to be able to
charge an entity. Its not a permission to access, its a "who is paying" and
that requires a real entity to charge to
