Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143925AbRAHOvH>; Mon, 8 Jan 2001 09:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144124AbRAHOu5>; Mon, 8 Jan 2001 09:50:57 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:59344 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S143925AbRAHOum>; Mon, 8 Jan 2001 09:50:42 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds),
        adam@yggdrasil.com (Adam J. Richter), parsley@roanoke.edu,
        linux-kernel@vger.kernel.org, riel@conectiva.com.br (Rik van Riel)
Subject: Re: Patch (repost): cramfs memory corruption fix
In-Reply-To: <E14FdV7-0004gd-00@the-village.bc.nu>
From: Christoph Rohland <cr@sap.com>
Date: 08 Jan 2001 15:49:49 +0100
In-Reply-To: Alan Cox's message of "Mon, 8 Jan 2001 14:42:18 +0000 (GMT)"
Message-ID: <qwwk886t7xu.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Mon, 8 Jan 2001, Alan Cox wrote:
> I have been thinking about this. I think we should merge the size
> limiting code with the example clean ramfs code. Having spent a
> while debugging the LFS checks and some other funnies I realised one
> problem with the ramfs in 2.4.0 as an example. It does not
> demonstrate error cases, which the new one does.

For demonstration purposes perhaps. But I do not see a lot of value of
using ramfs if shmem could do read and write.

Greetings
		Christoph
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
