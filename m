Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWEKQto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWEKQto (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWEKQto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:49:44 -0400
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:52888 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S1030354AbWEKQtn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:49:43 -0400
From: Rik Bobbaers <Rik.Bobbaers@cc.kuleuven.be>
Organization: KULueven - LUDIT
To: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: fix compiler warning in ip_nat_standalone.c
Date: Thu, 11 May 2006 18:49:41 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200605111729.48871.Rik.Bobbaers@cc.kuleuven.be> <20060511155537.GF1104@wohnheim.fh-wedel.de>
In-Reply-To: <20060511155537.GF1104@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605111849.41565.Rik.Bobbaers@cc.kuleuven.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 May 2006 17:55, Jörn Engel wrote:
> On Thu, 11 May 2006 17:29:48 +0200, Rik Bobbaers wrote:
> > i just made small patch that fixes a compiler warning:
>
> Just in case Al didn't make it clear enough in the recent thread:
>
> You cannot fix a compiler warning!
>
> Either the code is wrong or it is right.  A compiler warning can
> indicate that code is wrong, or it is a false positive.  If the code
> is wrong, fix the _code_.  If it isn't, ignore the warning or fix the
> _compiler_.

sry, i 'm not on lkml, so i didn't read the thread

> That said, your patch looks as if it would actually fix the code.  I'm
> not firm enough with NAT to confirm that, though.  So if it fixes the
> code, please state exactly that.

mkay... it fixes the code :)

-- 
harry
aka Rik Bobbaers

K.U.Leuven - LUDIT          -=- Tel: +32 485 52 71 50
Rik.Bobbaers@cc.kuleuven.be -=- http://harry.ulyssis.org

"Work hard and do your best, it'll make it easier for the rest"
-- Garfield

Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm

