Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271746AbTHMKzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 06:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271750AbTHMKzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 06:55:14 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:50904 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271746AbTHMKzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 06:55:10 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 13 Aug 2003 12:55:09 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: akpm@osdl.org, andrea@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030813125509.360c58fb.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0308081232430.8384-100000@logos.cnet>
References: <20030808170536.23118033.skraw@ithnet.com>
	<Pine.LNX.4.44.0308081232430.8384-100000@logos.cnet>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003 12:33:28 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> That will provide further information yes. We can then know if the problem 
> is reiserfs specific or not, which is VERY useful.
> 
> Again, thanks for your efforts helping us track down the problem.

Status update:

uptime:
 12:45pm  up 2 days 19:39,  18 users,  load average: 2.02, 2.05, 2.06

Running SMP. So far no crash happened under ext3. 
Still I see the tar-verification errors. None on the first day, 2 on the second
and 2 today so far.
I see a growing possibility that the formerly crashes are directly linked to a
reiserfs problem, maybe broken SMP-locking.
If it survives until sunday I will revert all ext3 back to reiserfs to be sure
it still crashes, then ideas for patches will be welcome :-)

Up to sunday I can try to look deeper into the verification troubles. To be
honest I already doubt today that I will see a crash with ext3 until sunday...

Regards,
Stephan

