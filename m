Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268865AbTBZSGC>; Wed, 26 Feb 2003 13:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268867AbTBZSGC>; Wed, 26 Feb 2003 13:06:02 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:29585 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S268865AbTBZSGA>; Wed, 26 Feb 2003 13:06:00 -0500
Date: Wed, 26 Feb 2003 18:22:39 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: "John W. M. Stevens" <john@betelgeuse.us>, linux-kernel@vger.kernel.org,
       lse-tech@projects.sourceforge.net
Subject: Re: Horrible L2 cache effects from kernel compile
Message-ID: <20030226182239.GA24720@bjl1.jlokier.co.uk>
References: <3E5ABBC1.8050203@us.ibm.com.suse.lists.linux.kernel> <b3ekil$1cp$1@penguin.transmeta.com.suse.lists.linux.kernel> <20030225170546.GA23772@morningstar.nowhere.lie.suse.lists.linux.kernel> <p733cmc8efa.fsf@amdsimf.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p733cmc8efa.fsf@amdsimf.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> "John W. M. Stevens" <john@betelgeuse.us> writes:
> 
> > http://www.sourcejudy.com/downloads/10minutes.htm
> 
> Feel free to code it up. If you did I'm sure someone would be willing
> to test it on large boxes too.
> 
> However with RCU in the equation looking may get very interesting...
> Hash tables have the advantage that they're simply enough for lockless
> tricks; balanced trees are likely not so lucky.
> 
> -Andi (who took a look at judy some time ago but it looked horribly 
> complicated, even worse so than skiplists)

Note that the Judy trees paper has some text deleted which begins
"{some Judy patent applications}... {Remainder deleted, sorry, you
don't need to read this to understand the released software.}".

Maybe some parts of the algorithm are patent-pending in the US?

-- Jamie
