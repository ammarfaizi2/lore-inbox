Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbTDCRDZ 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261380AbTDCRDZ 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:03:25 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12677
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261377AbTDCRCs 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 12:02:48 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030403171009.GC1092@iliana>
References: <1049383273.11742.0.camel@dhcp22.swansea.linux.org.uk>
	 <Pine.GSO.4.21.0304031831030.23642-100000@vervain.sonytel.be>
	 <20030403171009.GC1092@iliana>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049386531.11747.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Apr 2003 17:15:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-03 at 18:10, Sven Luther wrote:
> It has two outputs, where i can hook either a DVI or a VGA monitor. Each
> of these video outputs correspond to a viewport, and there is hardware
> which will let you set the output timings and the dot clock. You also
> have to configure which part of the framebuffer you are reading, and
> eventually setup a scaller to scale the pixels you read to the correct
> output buffer. You also have for each head a DDC/I2C bus you can use to
> speak with the monitor.

Very common except lower end stuff generally has a single frame buffer
that both show and cannot be split or scanned by multiple outputs at
different rates.

