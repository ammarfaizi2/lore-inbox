Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263581AbTD1Nou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 09:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTD1Nou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 09:44:50 -0400
Received: from ns.suse.de ([213.95.15.193]:30217 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263581AbTD1Not (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 09:44:49 -0400
To: root@chaos.analogic.com
Cc: Mark Grosberg <mark@nolab.conman.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall.
X-Yow: I predict that by 1993 everyone will live in and around LAS VEGAS and
 wear BEATLE HAIRCUTS!
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 28 Apr 2003 15:57:04 +0200
In-Reply-To: <Pine.LNX.4.53.0304280951500.16637@chaos> (Richard B. Johnson's
 message of "Mon, 28 Apr 2003 09:57:08 -0400 (EDT)")
Message-ID: <jeadea7mj3.fsf@sykes.suse.de>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3.50 (gnu/linux)
References: <Pine.BSO.4.44.0304272207431.23296-100000@kwalitee.nolab.conman.org>
	<Pine.LNX.4.53.0304280855240.16444@chaos>
	<jed6j67o4o.fsf@sykes.suse.de>
	<Pine.LNX.4.53.0304280951500.16637@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

|> On Mon, 28 Apr 2003, Andreas Schwab wrote:
|> 
|> > "Richard B. Johnson" <root@chaos.analogic.com> writes:
|> >
|> > |> The following is a "simple popem()', about as minimal as
|> > |> you can get and have it work.
|> >
|> > Except it doesn't.
|> >
|> > |>     i = 0;
|> > |>     args[i++] = "/bin/sh";
|> > |>     args[i++] = "-c";
|> > |>     args[i++] = strtok((char *)command, " ");
|> > |>     for(; i< NR_ARGS; i++)
|> > |>         if((args[i] = strtok(NULL, " ")) == NULL)
|> > |>             break;
|> 
|> Yes it does.

$ sh -c echo a b c

$ sh -c 'echo a b c'
a b c

Not what I call working.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
