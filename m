Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130467AbRCDK2i>; Sun, 4 Mar 2001 05:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRCDK23>; Sun, 4 Mar 2001 05:28:29 -0500
Received: from smtp-rt-12.wanadoo.fr ([193.252.19.60]:8087 "EHLO
	tamaris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130467AbRCDK2O>; Sun, 4 Mar 2001 05:28:14 -0500
Message-ID: <3AA21866.62907063@wanadoo.fr>
Date: Sun, 04 Mar 2001 11:26:46 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.76 [fr] (X11; U; Linux 2.4.3-pre1 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: linux-fbdev-devel@sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
        lad <linux-audio-dev@ginette.musique.umontreal.ca>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Brad Douglas <brad@neruo.com>
Subject: Re: [prepatches] removal of console_lock
In-Reply-To: <3AA1EF6C.A9C7613E@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> This patch fixes it.  Interrupts are enabled across all console operations.
> 
> It's still somewhat a work-in-progress.

The patch applies OK against 2.4.3-pre1
At the end of make bzImage I got
kerne/kernel.o(.text+0xcd00): undefined reference to 'in_interrupt'

PR
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
