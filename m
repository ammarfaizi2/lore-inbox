Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVCaHuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVCaHuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVCaHqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:46:37 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:404 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261153AbVCaHpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:45:05 -0500
Date: Thu, 31 Mar 2005 09:45:26 +0200
From: DervishD <lkml@dervishd.net>
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-libc-headers scsi headers vs libc scsi headers
Message-ID: <20050331074526.GA8614@DervishD>
Mail-Followup-To: Mariusz Mazur <mmazur@kernel.pl>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050330162114.GA1028@DervishD> <20050330181007.GA17835@DervishD> <200503302240.08200.mmazur@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200503302240.08200.mmazur@kernel.pl>
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

    Hi Mariusz :)

 * Mariusz Mazur <mmazur@kernel.pl> dixit:
> On ?roda 30 marzec 2005 20:10, DervishD wrote:
> >     Yes, I know, this is in the llh FAQ, but the answer starts with
> > 'Not too sure on this one', that's the reason I'm asking here...
> Use whatever works. And ignore anybody telling you, that your system will blow 
> up if you use the wrong headers to compile something.

    The fact is that, in the past, I've used kernel headers older
than my running kernel for building glibc and my system worked
seamlessly (although I don't use bleeding edge features, you know),
but I don't want to take risks.

    I don't know which set of headers will work, and in fact I don't
know if I must follow 'Linux From Scratch' advice and use raw kernel
headers for building glibc and LLH headers for any other thing. I
think I probably will use the LLH headers (including scsi) for
everything since glibc passes the 'make check' doing that... If I
screw my system badly, I have lotsa backups at hand.

    Thanks for your advice :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
