Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131809AbQLHXyb>; Fri, 8 Dec 2000 18:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132896AbQLHXyV>; Fri, 8 Dec 2000 18:54:21 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:2308 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131809AbQLHXyC>; Fri, 8 Dec 2000 18:54:02 -0500
Date: Fri, 8 Dec 2000 23:23:21 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Johannes Erdfelt <johannes@erdfelt.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: USB-related lockup in test12-pre5
In-Reply-To: <20001207134013.L935@sventech.com>
Message-ID: <Pine.LNX.4.30.0012082321160.1107-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Johannes Erdfelt wrote:

> Could you try the alternate UHCI driver? You may need to disable the
> UHCI driver you have configured for the option to become visible.

Differently broken:
	uhci: host controller process error. something bad happened
	uhci: host controller halted. very bad

... but at least the machine doesn't die. This was working in test11,
IIRC. Certainly in test10.


-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
