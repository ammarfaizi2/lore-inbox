Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289645AbSBEVzz>; Tue, 5 Feb 2002 16:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289653AbSBEVzp>; Tue, 5 Feb 2002 16:55:45 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:32459 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S289645AbSBEVzb>; Tue, 5 Feb 2002 16:55:31 -0500
Date: Tue, 5 Feb 2002 22:53:48 +0100
From: Kristian <kristian.peters@korseby.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New scheduler in 2.4. series?
Message-Id: <20020205225348.03f614fd.kristian.peters@korseby.net>
In-Reply-To: <Pine.LNX.4.33.0202060024430.22859-100000@localhost.localdomain>
In-Reply-To: <20020205222244.4b763103.kristian.peters@korseby.net>
	<Pine.LNX.4.33.0202060024430.22859-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.7.0claws5 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
> true, the old scheduler did not do much with the nice level. In the new
> scheduler there is some real difference between nice levels - and this is
> a feature. I'd suggest for you to try something like nice -5. What kind of
> application are you renicing?

Just multiple 'nice -n -20 tar -cvjf` in a row for "high priority backup when my DTLA drives makes wierd noises again". I'm just compiling -K2. (BTW: -J2 behaves really bad while moving windows during a kernel compilation.)

*Kristian

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :.........................:: ~/$ kristian@korseby.net :
