Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263185AbTCWUZJ>; Sun, 23 Mar 2003 15:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263186AbTCWUZJ>; Sun, 23 Mar 2003 15:25:09 -0500
Received: from dsl-213-023-220-176.arcor-ip.net ([213.23.220.176]:8837 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id <S263185AbTCWUZI> convert rfc822-to-8bit; Sun, 23 Mar 2003 15:25:08 -0500
From: Dominik Kubla <dominik@kubla.de>
To: Christoph Hellwig <hch@infradead.org>, Jan Dittmer <j.dittmer@portrix.net>
Subject: Re: i2c-via686a driver
Date: Sun, 23 Mar 2003 21:36:10 +0100
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <3E7E0B37.5060505@portrix.net> <20030323202743.A11150@infradead.org>
In-Reply-To: <20030323202743.A11150@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303232136.10089.dominik@kubla.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 23. März 2003 21:27 schrieb Christoph Hellwig:
> // The following register sets temp interrupt mode (bits 1-0 for temp1,
> // 3-2 for temp2, 5-4 for temp3).  Modes are:
> //    00 interrupt stays as long as value is out-of-range
> //    01 interrupt is cleared once register is read (default)
> //    10 comparator mode- like 00, but ignores hysteresis
> //    11 same as 00
>
> 	Please don't use C++-style comments in kernel code.
>

Why? It's a valid C99 feature and since the kernel already uses C99 
initializers it won't compile with compilers that choke on C99 comments 
anyway.

Dominik
-- 
Be at war with your voices, at peace with your neighbors, and let every new
year find you a better man. (Benjamin Franklin, 1706-1790)

