Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292555AbSCOOaw>; Fri, 15 Mar 2002 09:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292589AbSCOOag>; Fri, 15 Mar 2002 09:30:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53515 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292555AbSCOOaT>; Fri, 15 Mar 2002 09:30:19 -0500
Subject: Re: [patch] My AMD IDE driver, v2.7
To: pavel@suse.cz (Pavel Machek)
Date: Fri, 15 Mar 2002 14:45:46 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        galibert@pobox.com (Olivier Galibert),
        linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <20020314141342.B37@toy.ucw.cz> from "Pavel Machek" at Mar 14, 2002 02:13:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lsxm-0003om-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  s/CAP_SYS_RAWIO/CAP_DEVICE_CMD/ for the raw cmd ioctl interface.  Have 
> 
> Nobody uses capabilities these days, right?

Wrong. There are quite a few people using them, including large scale projects
and actual sold packages. For other reasons CAP_DEVICE_CMD doesn't work out
