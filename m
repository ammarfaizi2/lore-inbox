Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275021AbRJJVHA>; Wed, 10 Oct 2001 17:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275061AbRJJVGu>; Wed, 10 Oct 2001 17:06:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4620 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275021AbRJJVGj>; Wed, 10 Oct 2001 17:06:39 -0400
Subject: Re: parport_pc no license?
To: weber@nyc.rr.com (John Weber)
Date: Wed, 10 Oct 2001 22:12:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BC49A1F.27A876B0@nyc.rr.com> from "John Weber" at Oct 10, 2001 02:57:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15rQen-0000kq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get a warning message when loading the parport_pc module that refers
> to "no license".  Can anyone explain what this means?

The newer tools check for module license tags. Eventually this will be
useful because it will identify proprietary binary only stuff we don't want
reports form. In the short term it'll trigger a few of these because we
don't have all the tags in yet. The -ac tree is pretty close. Once I've 
got the next -ac out and resynched with 2.4.11 I'll push to Linus the
remaining ones only in my tree
