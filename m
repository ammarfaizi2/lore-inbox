Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135249AbRECVtn>; Thu, 3 May 2001 17:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135251AbRECVtd>; Thu, 3 May 2001 17:49:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40713 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135249AbRECVtY>; Thu, 3 May 2001 17:49:24 -0400
Subject: Re: [RFC] Direct Sockets Support??
To: Venkateshr@ami.com (Venkatesh Ramamurthy)
Date: Thu, 3 May 2001 22:52:43 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), pollard@tomcat.admin.navo.hpc.mil,
        Venkateshr@ami.com (Venkatesh Ramamurthy),
        linux-kernel@vger.kernel.org
In-Reply-To: <1355693A51C0D211B55A00105ACCFE6402B9DECE@ATL_MS1> from "Venkatesh Ramamurthy" at May 03, 2001 04:40:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vR1g-0006HT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Thats exactly my point, we need to define a new protocol family to
> support it. This means that all applications using PF_INET needs to be
> changed and recompiled. My basic argument goes like this if hardware can

Thanks to the magic of shared libraries and LD_PRELOAD a library hook can
actually make the decision underneath the application
