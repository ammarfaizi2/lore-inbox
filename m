Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTJWMoE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 08:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbTJWMoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 08:44:04 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:53149 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263571AbTJWMoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 08:44:01 -0400
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: "Toshio Spoor" <t_spoor@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Compaq Evo N1020v lockups.
Date: Wed, 22 Oct 2003 16:24:27 -0700
User-Agent: KMail/1.5.4
References: <Sea2-F19eS8IANIlk1W0000da00@hotmail.com>
In-Reply-To: <Sea2-F19eS8IANIlk1W0000da00@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310221624.28221.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toshio Spoor wrote:
> Hi,
>
> Here is a (very vague) bug report: (sorry for that)
>
> [1.] One line summary of the problem:
>
> Compaq Evo N1020v lockups. (notebook)
>
> [2.] Full description of the problem/report:
>
> Since 2.4.23-pre3 I experience lockups the same goes for (estimate)
> 2.6.0-test3 => (Looks some code has merged in test3 too from
> 2.4.23-pre3). Unfortunately I can't pin point the  problem because
> this lame Compaq laptop doesn't have a serial port. For now I am
> using 2.4.22 that kernel seems stable. Also I have tried to disable
> ACPI that didn't work either. So I suspect the cause of the problem
> is somewhere in the changes of 2.4.23-pre3. (By the way, it still
> crashes with higher pre versions e.g. pre7)
>

This looks like network lockup many (including me) were experiencing. 
Apparently problem is with (or around) 8139cp driver. The solution 
which worked for me and others was to stop using 8139cp module and 
use 8139too instead. See if it works for you.

Fedor.
