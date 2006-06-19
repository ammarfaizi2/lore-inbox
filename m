Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWFSLxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWFSLxI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 07:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWFSLxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 07:53:08 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:6105 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932367AbWFSLxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 07:53:07 -0400
Date: Mon, 19 Jun 2006 13:52:57 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Con Kolivas <kernel@kolivas.org>
cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [ckpatch][15/29] hz-no_default_250.patch
In-Reply-To: <200606191125.50826.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.61.0606191351350.31576@yvahk01.tjqt.qr>
References: <787b0d920606181752j4b7c7309t9c0ab9bf8da1537a@mail.gmail.com>
 <200606191125.50826.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Yes I stored a family of these values and 864 was ~ the optimum for a high 
>value for desktops and ~84 for a low value but were unpopular for not being 

82 IIRC.

>something decimally familiar. Also lots of code kind of broke with values 
>below 100 in the kernel.

Ought to be fixed. Just like the code which assumed 100 Hz and broke during 
the initial switch to 1000, before we went back again to 250. :p


Jan Engelhardt
-- 
