Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270257AbRHWT6V>; Thu, 23 Aug 2001 15:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270252AbRHWT6I>; Thu, 23 Aug 2001 15:58:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26890 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270195AbRHWT5z>; Thu, 23 Aug 2001 15:57:55 -0400
Subject: Re: macro conflict
To: twalberg@mindspring.com
Date: Thu, 23 Aug 2001 21:01:07 +0100 (BST)
Cc: jimlay@u.washington.edu (J. Imlay), linux-kernel@vger.kernel.org
In-Reply-To: <20010823143440.G20693@mindspring.com> from "Tim Walberg" at Aug 23, 2001 02:34:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15a0f5-0004UK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Consider what happens if someone writes min(++x,y) - the old
> version expands to (without some of the extra parens):
> 
> 	++x < y ? ++x : y

That has nothing to do with it

a) nobody does it and its a known property
b) that was perfectly fixable anyway
