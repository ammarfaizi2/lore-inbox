Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286824AbRLVQ5Y>; Sat, 22 Dec 2001 11:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286825AbRLVQ5P>; Sat, 22 Dec 2001 11:57:15 -0500
Received: from hermes.domdv.de ([193.102.202.1]:13062 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S286824AbRLVQ46>;
	Sat, 22 Dec 2001 11:56:58 -0500
Message-ID: <XFMail.20011222175451.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20011222165020Z286821-18284+6166@vger.kernel.org>
Date: Sat, 22 Dec 2001 17:54:51 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Andreas Kinzler <akinzler@gmx.de>
Subject: RE: Injecting packets into the kernel
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can use a raw socket:

socket(AF_INET,SOCK_RAW,IPPROTO_RAW);

On 22-Dec-2001 Andreas Kinzler wrote:
> I am trying to fix a problem in diald (demand dialing tool). The problem is
> that
> somewhen you need to resubmit IP packets to the kernel that were buffered
> while the
> link (PPP in most cases) was down. However, a bit of debugging showed that
> the method
> used in diald does not work. You cannot submit to ppp0 directly because of
> masq/forwaring
> issues. Can somebody give me some hints how to submit packets from a user
> mode programm.
> 
> Andreas
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
