Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265043AbSJWPDC>; Wed, 23 Oct 2002 11:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265044AbSJWPDC>; Wed, 23 Oct 2002 11:03:02 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:191 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265043AbSJWPDB>; Wed, 23 Oct 2002 11:03:01 -0400
Subject: Re: 2.5 Problem Report Status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jbradford@dial.pipex.com
Cc: tmolina@cox.net, erik@debill.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210231414.g9NEELVr004557@darkstar.example.net>
References: <200210231414.g9NEELVr004557@darkstar.example.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 16:25:43 +0100
Message-Id: <1035386743.4033.61.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 15:14, jbradford@dial.pipex.com wrote:
> definitely wrong, because I can actually hear the disk spindown for a
> fraction of a second, then spin up again, (at least with 2.5.43, so
> far not with 2.5.44).

Someone broke the power management code. When they fix it then I expect
the IDE powerdown stuff will behave better again. If you had scsi then
the scsi stuff may have been what broke it all.

