Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTH1XtG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 19:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbTH1XtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 19:49:05 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:55724 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S264470AbTH1Xpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 19:45:53 -0400
From: root@mauve.demon.co.uk
Message-Id: <200308282344.AAA26603@mauve.demon.co.uk>
Subject: Re: Lockless file readingu
To: ecki@calista.eckenfels.6bone.ka-ip.net (Bernd Eckenfels)
Date: Fri, 29 Aug 2003 00:44:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E19sUna-0003Zq-00@calista.inka.de> from "Bernd Eckenfels" at Aug 28, 2003 11:59:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> In article <200308281726.SAA24033@mauve.demon.co.uk> you wrote:
> > I'd be really surprised if there were that many pictures in the world.
> 
> Well, this is about probabilty. It does not mean that you need 2^64
> pictures, neighter does it mean you have a collision within 2^64 pictures.

Of course it dowesn't.
The probability gets rather smaller as numbers go down, and bigger as
they go up.
With 2^128 bits, the chance of a a collision between 2^64 randomly chosen 
pictures is 50%.
At 2^54 pictures, it's about one in a million, and at 2^34 (enough for
several pictures of everyone alive) one in a billion billion.
At more common numbers of pictures (say 2^14) it becomes vanishingly
unlikely for anyone to have two matching pictures (even with several billion
archives)

