Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130663AbRAQRNB>; Wed, 17 Jan 2001 12:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131527AbRAQRMv>; Wed, 17 Jan 2001 12:12:51 -0500
Received: from mailframe.cabinet.net ([213.169.1.9]:6161 "HELO
	mailframe.cabinet.net") by vger.kernel.org with SMTP
	id <S130663AbRAQRMh>; Wed, 17 Jan 2001 12:12:37 -0500
Date: Wed, 17 Jan 2001 19:12:14 +0200 (EET)
From: Jussi Hamalainen <count@theblah.org>
To: Tony Gale <gale@syntax.dera.gov.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: ipchains blocking port 65535
In-Reply-To: <XFMail.20010117145010.gale@syntax.dera.gov.uk>
Message-ID: <Pine.LNX.4.30.0101171911010.21865-100000@shodan.irccrew.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Tony Gale wrote:

> It looks like this is due to the odd way in which ipchains handles
> fragments. Try:
>
> echo 1 > /proc/sys/net/ipv4/ip_always_defrag

Thanks, this seems to do the trick. Does this oddity still exist
in 2.4?

-- 
-=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.org ]=-

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
