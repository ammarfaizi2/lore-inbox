Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWC1Hih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWC1Hih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 02:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWC1Hih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 02:38:37 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:7406 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932250AbWC1Hig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 02:38:36 -0500
Message-ID: <4428E7CB.6030407@s5r6.in-berlin.de>
Date: Tue, 28 Mar 2006 09:37:47 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Douglas Gilbert <dougg@torque.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Bodo Eggert <7eggert@gmx.de>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>	 <Pine.LNX.4.64.0603261424590.15714@g5.osdl.org>	 <4427FEC9.4010803@torque.net>	 <Pine.LNX.4.64.0603270854570.15714@g5.osdl.org>	 <20060327172530.GH3486@parisc-linux.org>	 <Pine.LNX.4.64.0603270936290.15714@g5.osdl.org> <1143489287.4970.76.camel@localhost.localdomain> <44285929.4020806@torque.net>
In-Reply-To: <44285929.4020806@torque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> Alan Cox wrote:
[host/ channel/ target/ LU enumeration...]
>> is still a very visible reality if you work in a data centre or with
>> server kit, or if you have tape arrays or multi-CD towers. The LUN or
>> device number in particular are generally the number emblazoned on each
>> slot in the unit
...
> USB multi-card readers seem to like the concept of LUNs as well.

Sure. The h:c:i:l tuple does not provide the LUN though, only an ersatz.
-- 
Stefan Richter
-=====-=-==- --== ===--
http://arcgraph.de/sr/
