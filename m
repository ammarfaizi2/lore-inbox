Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbRIDSqb>; Tue, 4 Sep 2001 14:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbRIDSqW>; Tue, 4 Sep 2001 14:46:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42509 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265249AbRIDSqO>; Tue, 4 Sep 2001 14:46:14 -0400
Subject: Re: page_launder() on 2.4.9/10 issue
To: jaharkes@cs.cmu.edu (Jan Harkes)
Date: Tue, 4 Sep 2001 19:49:47 +0100 (BST)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        riel@conectiva.com.br (Rik van Riel), linux-kernel@vger.kernel.org
In-Reply-To: <20010904135427.A30503@cs.cmu.edu> from "Jan Harkes" at Sep 04, 2001 01:54:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15eLGd-0004Gd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now for the past _9_ stable kernel releases, page aging hasn't worked
> at all!! Nobody seems to even have bothered to check. I send in a patch
> and you basically answer with "Ohh, but we know about that one. Just
> apply patch wizzbangfoo#105 which basically does everything differently".

Maybe you should take issue with the people applying random patches, missing
important ones and mixing and matching incompatible ideas in the main tree ?

The VM tuning in the -ac tree is a lot more reliable for most loads (its
certainly not perfect) and that is because the changes have been done and
tested one at a time as they are merged. Real engineering process is the
only way to get this sort of thing working well.

Alan
