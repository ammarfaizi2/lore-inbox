Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKHRFX>; Wed, 8 Nov 2000 12:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129159AbQKHRFO>; Wed, 8 Nov 2000 12:05:14 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:59881 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129132AbQKHRFC>; Wed, 8 Nov 2000 12:05:02 -0500
From: Christoph Rohland <cr@sap.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Szabolcs Szakacsits <szaka@f-secure.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@transmeta.com>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: Looking for better VM
In-Reply-To: <Pine.LNX.3.96.1001108172338.7153A-100000@artax.karlin.mff.cuni.cz>
Organisation: SAP LinuxLab
Date: 08 Nov 2000 18:03:09 +0100
In-Reply-To: Mikulas Patocka's message of "Wed, 8 Nov 2000 17:36:40 +0100 (CET)"
Message-ID: <qwwr94ml7le.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikulas,

On Wed, 8 Nov 2000, Mikulas Patocka wrote:
> BTW. Why does your OOM killer in 2.4 try to kill process that mmaped
> most memory? mmap is hamrless. mmap on files can't eat memory and
> swap.

Be careful: They may have shm segments mmaped!

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
