Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273888AbRI0Un0>; Thu, 27 Sep 2001 16:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273895AbRI0UnQ>; Thu, 27 Sep 2001 16:43:16 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:61191 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S273888AbRI0Um7>; Thu, 27 Sep 2001 16:42:59 -0400
Message-ID: <3BB20C27.4125F9BA@eisenstein.dk>
Date: Wed, 26 Sep 2001 19:11:03 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOM killer
In-Reply-To: <3BB34D5C.15C76E1A@yahoo.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Hood wrote:

> How about assigning each process a property similar to its niceness
> which would be used to decide which process to kill in the event of
> OOM?

Or maybe make it a configure option if Linux should over commit memory or
not.
In some cases it would be nice if you could be sure that the memory you got
was actually there, and for those cases you could build the kernel with
CONFIG_NO_MEM_OVERCOMMIT (or something like that) so that linux would simply
report ENOMEM when there's no more memory.


Best regards,
Jesper Juhl
juhl@eisenstein.dk



