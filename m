Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbVDYTBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVDYTBI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVDYTBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:01:07 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:14243 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261468AbVDYTBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:01:05 -0400
In-Reply-To: <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org>
To: 7eggert@gmx.de
Cc: akpm@osdl.org, Jan Hudec <bulb@ucw.cz>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Miklos Szeredi <miklos@szeredi.hu>,
       viro@parcelfarce.linux.theplanet.co.uk
MIME-Version: 1.0
Subject: Re: [PATCH] private mounts
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF9C5A2A1D.78873E27-ON88256FEE.00683441-88256FEE.00688DC9@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Mon, 25 Apr 2005 12:02:43 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 04/25/2005 15:01:00,
	Serialize complete at 04/25/2005 15:01:00
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>mknamespace -p users/$UID # (like mkdir -p)
>setnamespace users/$UID   # (like cd)
       ^^^^^^^^

You realize that 'cd' is a shell command, and has to be, I hope.  That 
little fact has thrown a wrench into many of the ideas in this thread.

