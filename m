Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289950AbSAKN3b>; Fri, 11 Jan 2002 08:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289951AbSAKN3Y>; Fri, 11 Jan 2002 08:29:24 -0500
Received: from falcon.etf.bg.ac.yu ([147.91.8.233]:58496 "EHLO
	falcon.etf.bg.ac.yu") by vger.kernel.org with ESMTP
	id <S289950AbSAKN3L>; Fri, 11 Jan 2002 08:29:11 -0500
Date: Fri, 11 Jan 2002 14:27:19 +0100 (CET)
From: Bosko Radivojevic <bole@falcon.etf.bg.ac.yu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] suser to capable changes in char driver
In-Reply-To: <E16P1Bp-0007Ww-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201111425230.1674-100000@falcon.etf.bg.ac.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jan 2002, Alan Cox wrote:

> You can't allow stealing of the controlling tty as TTY_CONFIG, it gives you
> direct access to fake input on that console so really wants to be rather
> higher.

I was in doubt about this. Maybe CAP_SYS_ADMIN is better?

Greetings


