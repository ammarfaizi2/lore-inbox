Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131004AbQLFUTz>; Wed, 6 Dec 2000 15:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130562AbQLFUTq>; Wed, 6 Dec 2000 15:19:46 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:27396 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S131008AbQLFUTc>; Wed, 6 Dec 2000 15:19:32 -0500
Date: Wed, 6 Dec 2000 20:49:04 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Trashing ext2 with hdparm
Message-ID: <20001206204904.A1083@gondor.com>
In-Reply-To: <3A2E767B.D74B24B5@Hell.WH8.TU-Dresden.De> <Pine.LNX.4.10.10012061141300.21407-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012061141300.21407-100000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Dec 06, 2000 at 11:41:51AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 11:41:51AM -0800, Andre Hedrick wrote:
> No way that this could cause corruption it is a read-only test.

It definitely does, I saw it, too.  It seems to be triggered
by invalidate_buffers().

Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
