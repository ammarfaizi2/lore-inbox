Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270185AbRHMNL0>; Mon, 13 Aug 2001 09:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270186AbRHMNLS>; Mon, 13 Aug 2001 09:11:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45316 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270185AbRHMNLH>; Mon, 13 Aug 2001 09:11:07 -0400
Subject: Re: 2.4.7-ac4 disk thrashing (SOLVED?)
To: Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-1?q?N=FCtzel?=)
Date: Mon, 13 Aug 2001 14:13:07 +0100 (BST)
Cc: phillips@bonn-fries.net (Daniel Phillips),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        reiserfs-list@namesys.com (ReiserFS List),
        mason@suse.com (Chris Mason), NikitaDanilov@Yahoo.COM (Nikita Danilov),
        tmv5@home.com (Tom Vier)
In-Reply-To: <E15WBGG-0006uH-00@the-village.bc.nu> from "Dieter =?iso-8859-1?q?N=FCtzel?=" at Aug 13, 2001 08:24:08 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WHWl-0007Nh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.7-ac1 +
> use-once-pages                                  		Daniel Phillips
> use-once-pages-2                                		Daniel Phillips
> transaction-tracking-2.diff                             		Chris Mason
> 2.4.7-unlink-truncate-rename-rmdir.dif          	Vladimir V.Saveliev
> 2.4.7-plug-hole-and-pap-5660-pathrelse-fixes.dif       Vladimir V.Saveliev

You mean "some weird hack of your own". Every bench I've done involving -ac
and use one has worked better without use once
