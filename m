Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbTDNNGQ (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 09:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbTDNNGQ (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 09:06:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36281
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261672AbTDNNGQ (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 09:06:16 -0400
Subject: Re: [PATCH] M68k IDE updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0304141122340.28305-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0304141122340.28305-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050322784.25353.35.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Apr 2003 13:19:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-14 at 10:24, Geert Uytterhoeven wrote:
> > What about optionally making fix_drive_id a platoform hook
> > (like it was, but with a reasonable default) to avoid clobbering
> > the common code with those #ifdefs ?
> 
> Yes, I already suggested that in my IDE patch for 2.4.x. But I was in a hurry,
> since I wanted to get m68k IDE working in 2.4.21.

The base kernel is not an appropriate place for hurrying. Lets fix this properly
even if it takes a bit of time


