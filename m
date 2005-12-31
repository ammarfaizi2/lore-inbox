Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVLaMJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVLaMJl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 07:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVLaMJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 07:09:40 -0500
Received: from [81.2.110.250] ([81.2.110.250]:24969 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751328AbVLaMJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 07:09:40 -0500
Subject: Re: PROBLEM: Linux ATAPI CDROM ->FIX: SAMSUNG CD-ROM SC-140
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Steven J. Hathaway" <shathawa@e-z.net>
Cc: andre@linux-ide.org, axobe@suse.de, linux-kernel@vger.kernel.org,
       andre@linuxdiskcert.org
In-Reply-To: <43B6146C.60E044FF@e-z.net>
References: <43B6146C.60E044FF@e-z.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 31 Dec 2005 12:06:28 +0000
Message-Id: <1136030788.28365.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-12-30 at 21:17 -0800, Steven J. Hathaway wrote:
> The fix is to add the following record to the drive_blacklist[] table.
> 
>      { "SAMSUNG CD-ROM SC-140",  "ALL" },

This is not a fix since you said before the drive worked back in 2.4.20.
You need to find out what in 2.4.20-21 broke the support rather than
just turning it off.

You could equally just use hdparm -d0 until you fix it.

Alan

