Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTELN57 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbTELN57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:57:59 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2200
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262151AbTELN56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:57:58 -0400
Subject: Re: 2.5.69, IDE TCQ can't be enabled
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Oliver Neukum <oliver@neukum.org>, Oleg Drokin <green@namesys.com>,
       lkhelp@rekl.yi.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0305121513270.18058-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0305121513270.18058-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052745124.31246.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 May 2003 14:12:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-12 at 14:16, Bartlomiej Zolnierkiewicz wrote:
> TCQ is marked EXPERIMENTAL and is known to be broken.
> Probably it should be marked DANGEROUS or removed?
> 
> Alan, what do you think?

If not then the drivers with their own request end code also need
fixing. I'd turn it off, its not as if the drive firmware seems too
happy about it either

