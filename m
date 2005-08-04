Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVHDGGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVHDGGz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVHDGGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:06:51 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:53705 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261891AbVHDGGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:06:43 -0400
Date: Thu, 4 Aug 2005 08:06:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Johan Veenhuizen <veenhuizen@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12.3] Deny chmod in /proc/<pid>/
In-Reply-To: <42f096e7.9SOTOrosbBYB6uCh%veenhuizen@users.sf.net>
Message-ID: <Pine.LNX.4.61.0508040804540.22272@yvahk01.tjqt.qr>
References: <42efd43d.ijkrXtpGJUM7deW2%veenhuizen@users.sf.net>
 <Pine.LNX.4.61.0508030816150.2263@yvahk01.tjqt.qr>
 <42f096e7.9SOTOrosbBYB6uCh%veenhuizen@users.sf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Did you mean "chmod"?

No, I really meant chown - which just turned up another should-not-be:
no warning is generated when trying to chown;
chmod is even _persistent_ - for the moment.

>And I don't even have "smaps".

Just take any file.


Jan Engelhardt
-- 
