Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289822AbSBEV0p>; Tue, 5 Feb 2002 16:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289826AbSBEV0X>; Tue, 5 Feb 2002 16:26:23 -0500
Received: from natwar.webmailer.de ([192.67.198.70]:6452 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S289822AbSBEV0N>; Tue, 5 Feb 2002 16:26:13 -0500
Date: Tue, 5 Feb 2002 22:22:44 +0100
From: Kristian <kristian.peters@korseby.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: lostlogic@lostlogicx.com, starfire@dplanet.ch,
        linux-kernel@vger.kernel.org
Subject: Re: New scheduler in 2.4. series?
Message-Id: <20020205222244.4b763103.kristian.peters@korseby.net>
In-Reply-To: <Pine.LNX.4.33.0202060004230.21710-100000@localhost.localdomain>
In-Reply-To: <20020205193856.7628dcb3.kristian.peters@korseby.net>
	<Pine.LNX.4.33.0202060004230.21710-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.7.0claws5 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
> if you are using nice -20 tasks then they might take CPU time away from
> lower priority tasks. This is why bigger negative nice levels should only
> be used sparingly. (and this is why it can only be done as root.)

Of course. But with the good old scheduler I've never had any problems. The system was very slow but continuously responsive. (low frequency timeslices between process rotations) With your -J2 patch it's getting really unusable. Maybe I should give -K2 a try.

*Kristian

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :.........................:: ~/$ kristian@korseby.net :
