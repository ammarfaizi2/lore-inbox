Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315443AbSEQHCS>; Fri, 17 May 2002 03:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSEQHCR>; Fri, 17 May 2002 03:02:17 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:13581 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S315443AbSEQHCP>; Fri, 17 May 2002 03:02:15 -0400
Date: Fri, 17 May 2002 09:01:40 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: linux-kernel@vger.kernel.org
Subject: Can BUG() also be used "safely" in interrupts?
Message-ID: <20020517090139.G635@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I have a routine to be used in an ISR or BH, where I like to use
BUG(), to flag real bugs the caller produces, if he uses it with
wrong arguments (namely: check for asserted interrupts according
to a mask and flag an BUG(), if the mask is bogus).

So can BUG() be used in an ISR or BH?

Thanks & Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
