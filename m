Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270528AbRHNIts>; Tue, 14 Aug 2001 04:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270529AbRHNIti>; Tue, 14 Aug 2001 04:49:38 -0400
Received: from cnxt10002.conexant.com ([198.62.10.2]:62801 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S270528AbRHNItS>; Tue, 14 Aug 2001 04:49:18 -0400
Date: Tue, 14 Aug 2001 10:49:19 +0200 (CEST)
From: <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@sophia-sousar2.nice.mindspeed.com>
To: "Herbert U. =?iso-8859-1?q?H=FCbner?=" 
	<herbert-u-.huebner@webave.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.8 - EMU10K1 - Kernel Compile Breaks in Module main.o
 - Missing Attachments
In-Reply-To: <01081322295000.01135@gotcha.friendglow.net>
Message-ID: <Pine.LNX.4.33.0108141048430.753-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001, Herbert U. Hübner wrote:

Fixed in 2.4.8-pre1

> Problem:
> Kernel compilation breaks with message
> main.o(.modinfo+0x40): multiple definition of `__module_author'
>
> Problem fix:
> Delete the /usr/src/linux/drivers/sound/emu10k1 tree and copy the tree of
> kernel 2.4.7 into 2.4.8. Then it works.
>
> Error Correction:
> Please, review the changes made to emu10k1 by Robert Love announced in
> Changelog-2.4.8 under "final:"
>
> Configuration file used for kernel compilation:
> see attached text file "config.emu10k".
> The contents of the config file has not changed since kernel 2.4.5 and worked
> for 2.4.6 and 2.4.7.
>
> Error log (make modules):
> see attached text file "module_emu10k.txt"
>
> Thanks for your kind attention to this matter.
>
> Regards
> Herbert U. Huebner <herbert-u-.huebner@webave.com>
>

