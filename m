Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271850AbRH1QrY>; Tue, 28 Aug 2001 12:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271821AbRH1QrO>; Tue, 28 Aug 2001 12:47:14 -0400
Received: from relay1.zonnet.nl ([62.58.50.37]:32429 "EHLO relay1.zonnet.nl")
	by vger.kernel.org with ESMTP id <S271809AbRH1QrK>;
	Tue, 28 Aug 2001 12:47:10 -0400
Message-ID: <3B8BCB1B.9C4B35C0@linux-m68k.org>
Date: Tue, 28 Aug 2001 18:47:23 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108280617250.8365-100000@penguin.transmeta.com>
		<3B8BA883.3B5AAE2E@linux-m68k.org> <je4rqsdv4z.fsf@sykes.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andreas Schwab wrote:

> There is no cast in the min/max macros.

Ok, it uses an assignment, but it has almost the same effect (except for
pointer/integer values).

bye, Roman
