Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317744AbSGPDNT>; Mon, 15 Jul 2002 23:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317746AbSGPDNS>; Mon, 15 Jul 2002 23:13:18 -0400
Received: from [193.14.93.89] ([193.14.93.89]:47876 "HELO acolyte.hack.org")
	by vger.kernel.org with SMTP id <S317744AbSGPDNS>;
	Mon, 15 Jul 2002 23:13:18 -0400
To: linux-kernel@vger.kernel.org
Cc: schilling@fokus.gmd.de
Subject: Re: IDE/ATAPI in 2.5
References: <200207151326.g6FDQ8nH020722@burner.fokus.gmd.de>
From: Christer Weinigel <wingel@acolyte.hack.org>
In-Reply-To: Joerg Schilling's message of "Mon, 15 Jul 2002 15:26:08 +0200 (CEST)"
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.5
Date: 16 Jul 2002 05:16:10 +0200
Message-ID: <m3it3g7479.fsf@acolyte.hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Joerg, sorry about the two copies, I'm new to gnus and missed that I
have to do a wide reply]

Joerg Schilling <schilling@fokus.gmd.de> writes:

> As my textual description has not been read, here comes a acsii art
> of the proposal for a driver structure:

So what you are suggesting is a lot of layering between the clients
and the hardware.  If you look at the history of Linux I would regard
most of the "middle layer" code as failures, what one does end up with
is a middle layer that is some sort of least common denominator that
makes noone happy.  A much better choice is to place common code (what
usually ends up in a middle layer) in a library, so that a driver can
choose either to use the common code, or to implement its own better
version that can take advantage of the hardware if possible.  

    /Christer

-- 
"Just how much can I get away with and still go to heaven?"
