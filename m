Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQJ0KjQ>; Fri, 27 Oct 2000 06:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129886AbQJ0KjG>; Fri, 27 Oct 2000 06:39:06 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:44301
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129226AbQJ0Ki4>; Fri, 27 Oct 2000 06:38:56 -0400
Date: Fri, 27 Oct 2000 06:48:31 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: kernel@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test9 + LFS
Message-ID: <20001027064831.A20958@animx.eu.org>
In-Reply-To: <20001026215606.A19958@animx.eu.org> <Pine.LNX.3.96.1001026231315.22907A-100000@kanga.kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.3.96.1001026231315.22907A-100000@kanga.kvack.org>; from kernel@kvack.org on Thu, Oct 26, 2000 at 11:15:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I attempted to create a 4gb sparce file with dd.  It failed.
> > I created one that was 2.1gb in size which worked.  Then I appeneded more
> > junk to the end of the file making it over 2.2gb.
> > 
> > doing an ls -l shows:
> > ls: x: Value too large for defined data type
> > 
> > NOTE: this worked in 2.4.0-test6 and I believe it stopped working around
> > test8, but I'm not sure.  May have been around test7.
> 
> Previous kernels allowed up to 4gb to be returned by the old stat.
> Upgrade your glibc and fileutils -- most recent distributions (Red Hat,
> SuSE, ...) are LFS ready, and the only reports I've seen about this
> concerned Slackware.

I did upgrade that and it didn't help anything.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
