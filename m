Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWBQPd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWBQPd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWBQPd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:33:57 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:38118 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750790AbWBQPd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:33:57 -0500
Date: Fri, 17 Feb 2006 16:33:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
cc: Rob Landley <rob@landley.net>, Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060215195039.GS29938@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.61.0602171631120.27452@yvahk01.tjqt.qr>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
 <200602142155.03407.rob@landley.net> <20060215183115.GE29940@csclub.uwaterloo.ca>
 <200602151409.41523.rob@landley.net> <20060215195039.GS29938@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>How do you share a raid between two systems?  I know you probably can't
>make every redundant, but you can try. :)
>
Make a mirror /dev/md0 out of /dev/nb0 and /dev/nb1.
Of course, you should only mount the filesystem once (to avoid 
corruptions), so the only "software" way of sharing is nfs, etc.
Or stuff like ocfs, whatever.


Jan Engelhardt
-- 
