Return-Path: <linux-kernel-owner+w=401wt.eu-S932425AbWLSOew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWLSOew (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 09:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWLSOew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 09:34:52 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:37174 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932453AbWLSOev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 09:34:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=NY9/pDHjgcZ65ROzJBox0pbBGQ0LRPbzRoE9WdccztyYlFey/CwcjB/QU0N+hqhQ7rYd8PFaJh/PVL1/SgSBswD7BhkL+KZ78zMNpCjz13uB3VSXGrxZB13O7C92hi3iPotudBYRLGoZWwon1HUej80qB5wMc95aZCrxc+1QfSs=
Message-ID: <4587F87C.2050100@gmail.com>
Date: Tue, 19 Dec 2006 23:34:36 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
References: <45841710.9040900@t-online.de>
In-Reply-To: <45841710.9040900@t-online.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (BMDMA stat 0x1)
> ata2.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata2: soft resetting port
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata2.00: model number mismatch 'TSSTcorpCD/DVDW SH-S183A' != '—≈Ãhı≥Nı

This is really fishy.  Something really went wrong there.  Please post
full dmesg and does the drive work at all? - eg. data dvd or cd.  How
reproducible is the problem?  What program did you use to play dvd?  If
mplayer, please run it with -v and post what it says (usb case too).

-- 
tejun
