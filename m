Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129685AbQLESnO>; Tue, 5 Dec 2000 13:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbQLESnE>; Tue, 5 Dec 2000 13:43:04 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:20027 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S130063AbQLESmu>;
	Tue, 5 Dec 2000 13:42:50 -0500
Message-ID: <20001205191224.A11904@win.tue.nl>
Date: Tue, 5 Dec 2000 19:12:24 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Daniel Sangenberg <daniel@datanova.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.17 + ide patches + 61gb ibm disc = problem
In-Reply-To: <5.0.1.4.2.20001205170724.00b30458@mail.datanova.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <5.0.1.4.2.20001205170724.00b30458@mail.datanova.se>; from Daniel Sangenberg on Tue, Dec 05, 2000 at 05:15:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2000 at 05:15:25PM +0100, Daniel Sangenberg wrote:

> I have a problem with 2.2.17 + the latest ide patches and 2 * 61 gb ibm ide 
> discs, the discs are connected as slave on a two channels (onboard ide 
> channels on a asus p2b (i440BX Chipset)), there is nohing else connected on 
> the ide interface and the jumper settings are identical.

> hdb: IBM-DTLA-307060, 58644MB w/1916kB Cache, CHS=7476/255/63, UDMA(33)
> hdd: IBM-DTLA-307060, 58644MB w/1916kB Cache, CHS=119150/16/63, UDMA(33)

> The difference in size and cylinders could cause a problem if this changes 
> in later versions, is this normal behaviour or did i do something wrong ?

This is normal behaviour. See
	http://www.win.tue.nl/~aeb/linux/Large-Disk-14.html#ss14.2
("14.2 Nonproblem: Identical disks have different geometry?")
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
