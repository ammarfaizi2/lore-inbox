Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279640AbRJXXeV>; Wed, 24 Oct 2001 19:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279644AbRJXXeG>; Wed, 24 Oct 2001 19:34:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38667 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279640AbRJXXdx>; Wed, 24 Oct 2001 19:33:53 -0400
Subject: Re: Machine Check Exception in >2.4.5: Where to comment MCE out?
To: maneman@gmx.net (Mike)
Date: Thu, 25 Oct 2001 00:40:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BD74E4C.8A9BB52C@gmx.net> from "Mike" at Oct 25, 2001 01:27:08 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wXdd-00036K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is fixed in a current -ac tree. We default to not enabling MCE on
pentiums unless asked to do so. Too many pentium boards have the external
part of the MCE handling un or miswired
