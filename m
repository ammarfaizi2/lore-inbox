Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVCaOTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVCaOTy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVCaOTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:19:53 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:26775 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261465AbVCaOT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:19:28 -0500
Date: Thu, 31 Mar 2005 16:20:00 +0200
From: DervishD <lkml@dervishd.net>
To: pavan kishore <kisspinku@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TFTP design and implimentation
Message-ID: <20050331142000.GB654@DervishD>
Mail-Followup-To: pavan kishore <kisspinku@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20050331105322.14908.qmail@web90108.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050331105322.14908.qmail@web90108.mail.scd.yahoo.com>
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

    Hi Pavan :)

 * pavan kishore <kisspinku@yahoo.com> dixit:
> i'm doing project on TFTP n need the practical scenario
> of implimentation.assist me in bringing out the best design.

    In the kernel? Why? There are a couple tftp implementations out
there quite good. IIRC, H.Peter Anvin has one.

    IMO you should handle TFTP outside the kernel, specially if
you're tweaking a kernel just to add tftp to it. Are you sure you
cannot do it as an userspace app?

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
