Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276090AbRJBSKk>; Tue, 2 Oct 2001 14:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276089AbRJBSKa>; Tue, 2 Oct 2001 14:10:30 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:23038 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S276087AbRJBSKV>; Tue, 2 Oct 2001 14:10:21 -0400
Date: Tue, 2 Oct 2001 14:10:41 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Andrew Morton <akpm@zip.com.au>
cc: Lorenzo Allegrucci <lenstra@tiscalinet.it>, <linux-kernel@vger.kernel.org>
Subject: Re: Huge console switching lags
In-Reply-To: <3BB9F1F2.B6873DFD@zip.com.au>
Message-ID: <Pine.GSO.4.33.0110021408310.22872-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2001, Andrew Morton wrote:
>In 2.4.10, the console switching code moved from interrupt context
>into process context.  So if your system is taking a long time to
>schedule processes (in this case, keventd) then yes, console
>switching will take a long time.

And what's the brilliant reason for this?  And don't give any BS about it
taking too long inside an interrupt context -- we're switching consoles not
start netscrape.

--Ricky


