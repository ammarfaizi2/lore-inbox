Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135303AbRAVV7H>; Mon, 22 Jan 2001 16:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135304AbRAVV66>; Mon, 22 Jan 2001 16:58:58 -0500
Received: from Cantor.suse.de ([194.112.123.193]:2067 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135303AbRAVV6k>;
	Mon, 22 Jan 2001 16:58:40 -0500
Date: Mon, 22 Jan 2001 22:58:23 +0100
From: Andi Kleen <ak@suse.de>
To: Bill Hartner <bhartner@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] more on scheduler benchmarks
Message-ID: <20010122225823.A14248@gruyere.muc.suse.de>
In-Reply-To: <OF6D592D2B.0F27DA28-ON852569DC.0066C241@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF6D592D2B.0F27DA28-ON852569DC.0066C241@raleigh.ibm.com>; from bhartner@us.ibm.com on Mon, Jan 22, 2001 at 02:23:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2001 at 02:23:05PM -0500, Bill Hartner wrote:
> Mike K, wrote :
> 
> >
> > If the above is accurate, then I am wondering what would be a
> > good scheduler benchmark for these low task count situations.
> > I could undo the optimizations in sys_sched_yield() (for testing
> > purposes only!), and run the existing benchmarks.  Can anyone
> > suggest a better solution?
> 
> Hacking sys_sched_yield is one way around it.

How about process pairs that bounce around tokens in pipes ? 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
