Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289823AbSBEV3D>; Tue, 5 Feb 2002 16:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289833AbSBEV2x>; Tue, 5 Feb 2002 16:28:53 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62677 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289823AbSBEV2i>;
	Tue, 5 Feb 2002 16:28:38 -0500
Date: Wed, 6 Feb 2002 00:26:25 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Kristian <kristian.peters@korseby.net>
Cc: lostlogic <lostlogic@lostlogicx.com>, starfire <starfire@dplanet.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: New scheduler in 2.4. series?
In-Reply-To: <20020205222244.4b763103.kristian.peters@korseby.net>
Message-ID: <Pine.LNX.4.33.0202060024430.22859-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Feb 2002, Kristian wrote:

> Of course. But with the good old scheduler I've never had any
> problems. The system was very slow but continuously responsive. [...]

true, the old scheduler did not do much with the nice level. In the new
scheduler there is some real difference between nice levels - and this is
a feature. I'd suggest for you to try something like nice -5. What kind of
application are you renicing?

	Ingo

