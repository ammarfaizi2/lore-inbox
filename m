Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316906AbSFVVZe>; Sat, 22 Jun 2002 17:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316912AbSFVVZd>; Sat, 22 Jun 2002 17:25:33 -0400
Received: from e.kth.se ([130.237.48.5]:54021 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S316906AbSFVVZb>;
	Sat, 22 Jun 2002 17:25:31 -0400
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [FREEZE] 2.4.19-pre10 + Promise ATA100 tx2 ver 2.20
References: <3D14C06F.6010906@fabbione.net>
	<yw1xwusrkv9h.fsf@gladiusit.e.kth.se> <3D14C7B8.9030705@fabbione.net>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 22 Jun 2002 23:25:31 +0200
In-Reply-To: Fabio Massimo Di Nitto's message of "Sat, 22 Jun 2002 20:53:44 +0200"
Message-ID: <yw1x3cvfvwdw.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Massimo Di Nitto <fabbione@fabbione.net> writes:

> Måns Rullgård wrote:
> >Does the machine recover from the freeze or do you have to reboot?
>
> I have to hard reset the machine. Keyboard is unuseable at that stage.
> not even Magic sysreq works.

Are you running X? If yes, try reproducing the error while at a text
console. It's possible some panic message will make it that far. Messages
from a dying kernel will often not make it into the syslog.

-- 
Måns Rullgård
mru@users.sf.net
