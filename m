Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVCTPw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVCTPw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 10:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVCTPw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 10:52:56 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:4056 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261231AbVCTPwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 10:52:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GX3q7nDkUzMbNM/ALMwDqo/X9a1164Os7oH7b3M9c+uKMZ2OISP9vguKvD6aDZ9QUFX/X+lLhTWNU1nO92Xrb5uCM7dk1lbo4Xs9HWFK9DdMBiHTzdASzcXadkn3hkLWT6BCCPbRcpa4GqujjxpgUb6E/UqJMoelrtFHMXCXsDE=
Message-ID: <aec7e5c30503200752b438910@mail.gmail.com>
Date: Sun, 20 Mar 2005 16:52:54 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: af_unix.c, KBUILD_MODNAME and unix
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0503201501410.31392@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <aec7e5c305032005451899b18b@mail.gmail.com>
	 <20050320135207.A12839@flint.arm.linux.org.uk>
	 <Pine.LNX.4.61.0503201501410.31392@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> af_unix.c is currenty built with KBUILD_MODNAME=unix. This seems to
> >> Solution? #undef unix?
> >
> >or maybe -Uunix ?
> 
> Why is not KBUILD_MODNAME=af_unix ?

The exact solution does not matter that much to me, and I'm afraid I
do not know how changing KBUILD_MODNAME affects the rest of the
codebase. So basically - someone else should decide... but who?

/ magnus
