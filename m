Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268091AbTBYRKo>; Tue, 25 Feb 2003 12:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268095AbTBYRKn>; Tue, 25 Feb 2003 12:10:43 -0500
Received: from ns.suse.de ([213.95.15.193]:54032 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268091AbTBYRKm>;
	Tue, 25 Feb 2003 12:10:42 -0500
To: "John W. M. Stevens" <john@betelgeuse.us>
Cc: linux-kernel@vger.kernel.org, lse-tech@projects.sourceforge.net
Subject: Re: Horrible L2 cache effects from kernel compile
References: <3E5ABBC1.8050203@us.ibm.com.suse.lists.linux.kernel> <b3ekil$1cp$1@penguin.transmeta.com.suse.lists.linux.kernel> <20030225170546.GA23772@morningstar.nowhere.lie.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 25 Feb 2003 18:20:57 +0100
In-Reply-To: "John W. M. Stevens"'s message of "25 Feb 2003 18:11:19 +0100"
Message-ID: <p733cmc8efa.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John W. M. Stevens" <john@betelgeuse.us> writes:

> http://www.sourcejudy.com/downloads/10minutes.htm

Feel free to code it up. If you did I'm sure someone would be willing
to test it on large boxes too.

However with RCU in the equation looking may get very interesting...
Hash tables have the advantage that they're simply enough for lockless
tricks; balanced trees are likely not so lucky.

-Andi (who took a look at judy some time ago but it looked horribly 
complicated, even worse so than skiplists)
