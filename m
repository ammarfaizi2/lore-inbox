Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbVHRKEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVHRKEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 06:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVHRKED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 06:04:03 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:16091 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S932160AbVHRKEC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 06:04:02 -0400
Date: Thu, 18 Aug 2005 12:07:33 +0200
From: DervishD <lkml@dervishd.net>
To: jeff shia <tshxiayu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can I write to the cdrom through writing to the device file sr0?
Message-ID: <20050818100733.GA110@DervishD>
Mail-Followup-To: jeff shia <tshxiayu@gmail.com>,
	linux-kernel@vger.kernel.org
References: <7cd5d4b4050818014042740322@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cd5d4b4050818014042740322@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jeff :)

 * jeff shia <tshxiayu@gmail.com> dixit:
> I want to write a cdrw user space driver just like cdreord,but the
> cdrecord is too complex and huge!can I write to the cdrom through
> writing to the device file sr0,here sr0 is the device file of the
> cdrw.

    Although someone may say that the size of cdrecord is
proportional to the author's ego, the crude reality is that cdrecord
has to be such complex and huge (well, I don't think it is huge,
but...). It has to be complex because cdwriting *is* complex. Take a
look at the code and see if you can get rid of things. Nowadays I
think that most of the writers out there are SCSI-3/MMC compliant, so
you can just use that driver, but that won't probably remove much
code.

    Try joining a cdrecord alternative. I don't remember the name,
but a project to build a cd recording library exists.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
