Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbTEDQyg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 12:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbTEDQyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 12:54:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7841
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261165AbTEDQye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 12:54:34 -0400
Subject: Re: [PATCH] Workaround bogus CF cards
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1052043277.4107.76.camel@gaston>
References: <1052043277.4107.76.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052064504.1240.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 May 2003 17:08:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-05-04 at 11:14, Benjamin Herrenschmidt wrote:
> Hi !
> 
> I had a problem with an "APACER" Compact Flash card. It seems that
> beast is allergic to WIN_READ_NATIVE_MAX.

Thats probably a drive->flash check you need looking at the docs I have
I don't see where any CF supports READ_NATIVE_MAX (of course it shouldnt
die either)

