Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287886AbSBRVhY>; Mon, 18 Feb 2002 16:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287817AbSBRVhM>; Mon, 18 Feb 2002 16:37:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43784 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287699AbSBRVhD>; Mon, 18 Feb 2002 16:37:03 -0500
Subject: Re: time goes backwards periodically on laptop if booted in low-power mode
To: ncw@axis.demon.co.uk (Nick Craig-Wood)
Date: Mon, 18 Feb 2002 21:50:44 +0000 (GMT)
Cc: dank@kegel.com (Dan Kegel),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <20020218213049.A28604@axis.demon.co.uk> from "Nick Craig-Wood" at Feb 18, 2002 09:30:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16cvgK-0006uq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This isn't fixing the root cause of the problem which is interactions
> between the BIOS power management and the kernel I believe, but it
> does fix the problem and is really quite cheap so perhaps might be

do_gettimeofday is still going to give strange results - and consider
the case where you boot slow and speed up...

If you can give me the DMI strings for the affected boxes I can add
them to the DMi tables (see ftp://ftp.linux.org.uk/pub/linux/alan/DMI*)
