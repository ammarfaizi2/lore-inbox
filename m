Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbTDNNIb (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 09:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbTDNNIb (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 09:08:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37817
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262998AbTDNNIa (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 09:08:30 -0400
Subject: Re: [PATCH] M68k IDE updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0304141037410.28305-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0304141037410.28305-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050322915.25353.38.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Apr 2003 13:21:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-14 at 09:39, Geert Uytterhoeven wrote:
> Indeed. Ataris and Q40/Q60s have byteswapped IDE busses, but they expect
> on-disk data to be that way, for compatibility with e.g. TOS.

That is a higher level problem. You need a byteswap mode for the loop device
it seems. Then you can read atari disks on any box..


