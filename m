Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVBNR2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVBNR2j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 12:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVBNR2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 12:28:39 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:33239 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261493AbVBNR2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 12:28:34 -0500
Date: Mon, 14 Feb 2005 18:29:44 +0100
From: DervishD <lkml@dervishd.net>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: How to get the maximum output from dmesg command
Message-ID: <20050214172944.GA17334@DervishD>
Mail-Followup-To: "Srinivas G." <srinivasg@esntechnologies.co.in>,
	linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
References: <4EE0CBA31942E547B99B3D4BFAB3481134E2AE@mail.esn.co.in> <20050214161950.GA10253@DervishD> <20050214164810.GA12738@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050214164810.GA12738@ime.usp.br>
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

    Hi Rogério :)

 * Rogério Brito <rbrito@ime.usp.br> dixit:
> Srinivas G. <srinivasg@esntechnologies.co.in> wrote:
> > I saw in printk.c file under source directory. There I found LOG_BUF_LEN
> > is 16384.
> Sorry if this is obvious, but have you considered using the -s option of
> dmesg?

    Of course, there is no point in making your LOG_BUF larger in the
kernel if dmesg is going to present just 2^14 bytes at most. You have
to use -s, Srinivas.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
