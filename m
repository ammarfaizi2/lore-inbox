Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291624AbSB0LhW>; Wed, 27 Feb 2002 06:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292326AbSB0LhN>; Wed, 27 Feb 2002 06:37:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40066 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291624AbSB0Lg6> convert rfc822-to-8bit;
	Wed, 27 Feb 2002 06:36:58 -0500
Date: Wed, 27 Feb 2002 03:34:55 -0800 (PST)
Message-Id: <20020227.033455.13771237.davem@redhat.com>
To: linux-kernel@vger.kernel.org, tlan@stud.ntnu.no
Cc: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020227120549.A8734@stud.ntnu.no>
In-Reply-To: <20020226164044.A7726@stud.ntnu.no>
	<20020226.185630.104030430.davem@redhat.com>
	<20020227120549.A8734@stud.ntnu.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Langås <tlan@stud.ntnu.no>
   Date: Wed, 27 Feb 2002 12:05:49 +0100
   
   > If the module still fails to load because of the -EBUSY error (ie. the
   > "read_partno returns -19" thing happens again), bring
   > drivers/net/tg3.c into an editor and go to around line 4185 and change
   > the line that reads:
   >  [snipp]
   > And see if it works then.  PLEASE type sync a few times before trying
   > to load the module in this case as it could very well hang your
   > machine.
   
   Didn't work, didn't hang the box either :)

What did it print out when you changed the code to
be "while (1)"?  It must print something different.

