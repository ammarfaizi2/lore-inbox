Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288597AbSAYXAX>; Fri, 25 Jan 2002 18:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287860AbSAYXAO>; Fri, 25 Jan 2002 18:00:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2322 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288597AbSAYW75>;
	Fri, 25 Jan 2002 17:59:57 -0500
Message-ID: <3C51E36B.6296299D@mandrakesoft.com>
Date: Fri, 25 Jan 2002 17:59:55 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andrea_ferraris@libero.it
CC: linux-kernel@vger.kernel.org
Subject: Re: eth0: NULL pointer encountered in RX ring, skipping
In-Reply-To: <20020125180149.GB45738@compsoc.man.ac.uk> <20020125133814.U763@lynx.adilger.int> <20020125231555.A22583@wotan.suse.de> <0201252332430B.01074@af>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the code says "this should never happen" ;-)

But anyway, it is probably a temporary memory allocation failure.  The
code handles this case.

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
