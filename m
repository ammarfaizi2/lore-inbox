Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288985AbSANTbx>; Mon, 14 Jan 2002 14:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288994AbSANTab>; Mon, 14 Jan 2002 14:30:31 -0500
Received: from ausxc08.us.dell.com ([143.166.227.176]:58122 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S288995AbSANTaK>; Mon, 14 Jan 2002 14:30:10 -0500
Message-ID: <71714C04806CD5119352009027289217022C423D@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: linux-kernel@vger.kernel.org
Subject: RE: struct gendisk max_p gone in 2.5.x
Date: Mon, 14 Jan 2002 13:30:02 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The max_p member of struct gendisk was deleted in 2.5.x.  

I found it.  1 << gd->minor_shift, per Andries Brouwer's patch of June 2001.
-Matt
--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
#1 US Linux Server provider with 24.5% (IDC Dec 2001)
#2 Worldwide Linux Server provider with 18.2% (IDC Dec 2001)
