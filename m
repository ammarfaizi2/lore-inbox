Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130382AbRAaUJo>; Wed, 31 Jan 2001 15:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131091AbRAaUJe>; Wed, 31 Jan 2001 15:09:34 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:27153
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130963AbRAaUJU>; Wed, 31 Jan 2001 15:09:20 -0500
Date: Wed, 31 Jan 2001 12:08:58 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Mark Lord <mlord@pobox.com>
cc: Rupa Schomaker <rupa-list+linux-kernel@rupa.com>, Andries.Brouwer@cwi.nl,
        ole@linpro.no, linux-kernel@vger.kernel.org
Subject: Re: Problems with Promise IDE controller under 2.4.1
In-Reply-To: <3A786FDB.F7B2DF78@pobox.com>
Message-ID: <Pine.LNX.4.10.10101311207090.13759-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Mark Lord wrote:

> Simple solution is to have kernel fall-back to LBA style
> translations instead of kernel "basic" translations.
> This would make it match the first two "BIOS" drives
> on most systems, and not really hurt anything in most cases.
> 
> Even better would be to add a stage in front of the fall-back,
> which queries the BIOS (from kernel startup code) for translation
> info on ALL drives.

We did that once Mark and people bitch as squealed like a stuck pig!

Also, Linus is still on the line and holding that linux has a policy of
not policies.

Maybe a compile option could help...

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
