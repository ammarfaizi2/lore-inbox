Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129314AbQK2BD7>; Tue, 28 Nov 2000 20:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129183AbQK2BDj>; Tue, 28 Nov 2000 20:03:39 -0500
Received: from sith.mimuw.edu.pl ([193.0.97.1]:22276 "HELO sith.mimuw.edu.pl")
        by vger.kernel.org with SMTP id <S129091AbQK2BD2>;
        Tue, 28 Nov 2000 20:03:28 -0500
Date: Wed, 29 Nov 2000 01:34:59 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no RLIMIT_NPROC for root, please
Message-ID: <20001129013459.B20515@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001128214309.F2680@sith.mimuw.edu.pl> <E140shP-00055W-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <E140shP-00055W-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 28, 2000 at 09:54:00PM +0000
X-Operating-System: Linux 2.4.0-test11-pre6 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Alan Cox wrote:

> > Why is RLIMIT_NPROC apllied to root(uid 0) processes? It's not kernel j=
> > ob to
> > prevent admin from shooting him/her self in the foot.
> > 
> > root should be able to do fork() regardless of any limits,
> > and IMHO the following patch is the right thing.
> 
> This patch is bogus. root can always raise their limit. But having root
> tasks by default not take out the box is good

OK, I just fix applications that assume root = no limits ;)

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, type MANIAC         |                   -- TROOPS by Kevin Rubio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
