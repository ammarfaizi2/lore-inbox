Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVHXHu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVHXHu2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVHXHu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:50:28 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:36566 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1750738AbVHXHu2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:50:28 -0400
Date: Wed, 24 Aug 2005 09:54:08 +0200
From: DervishD <lkml@dervishd.net>
To: jeff shia <tshxiayu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what does the CDROMREADTOCHDR means?
Message-ID: <20050824075408.GB74@DervishD>
Mail-Followup-To: jeff shia <tshxiayu@gmail.com>,
	linux-kernel@vger.kernel.org
References: <7cd5d4b4050823215212491130@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cd5d4b4050823215212491130@mail.gmail.com>
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
> in the file of cdrom.c,what dose the ioctl command
> CDROMREADTOCHDR&CDROMREADTOCENTRY means?

    It's obvious...

    CDROMREADTOCHDR == CDROM READ TOC HEADER
    CDROMREADTOCENTRY == CDROM READ TOC ENTRY

    They're ioctl's to handle the TOC of a CD.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
