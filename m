Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129410AbQK1Vte>; Tue, 28 Nov 2000 16:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129925AbQK1VtY>; Tue, 28 Nov 2000 16:49:24 -0500
Received: from sith.mimuw.edu.pl ([193.0.97.1]:23815 "HELO sith.mimuw.edu.pl")
        by vger.kernel.org with SMTP id <S129410AbQK1VtL>;
        Tue, 28 Nov 2000 16:49:11 -0500
Date: Tue, 28 Nov 2000 22:20:40 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no RLIMIT_NPROC for root, please
Message-ID: <20001128222040.H2680@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
        Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20001128214309.F2680@sith.mimuw.edu.pl> <200011282111.eASLB6k05926@hawking.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011282111.eASLB6k05926@hawking.suse.de>; from schwab@suse.de on Tue, Nov 28, 2000 at 10:11:07PM +0100
X-Operating-System: Linux 2.4.0-test11-pre6 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Andreas Schwab wrote:

> Jan Rekorajski <baggins@sith.mimuw.edu.pl> writes:
> 
> |> Why is RLIMIT_NPROC apllied to root(uid 0) processes? It's not kernel job to
> |> prevent admin from shooting him/her self in the foot.
> |> 
> |> root should be able to do fork() regardless of any limits,
> |> and IMHO the following patch is the right thing.
> 
> AFAICS, _all_ resource limits are equally applied to root processes.  Why
> should NPROC be different?

Because you want to be able to `kill <pid>`?
And if you are over-limits you can't?

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, type MANIAC         |                   -- TROOPS by Kevin Rubio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
