Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSCOT2p>; Fri, 15 Mar 2002 14:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293201AbSCOT2g>; Fri, 15 Mar 2002 14:28:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11271 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293190AbSCOT2T>;
	Fri, 15 Mar 2002 14:28:19 -0500
Date: Fri, 15 Mar 2002 19:28:18 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Joel Becker <jlbec@evilplan.org>, Rusty Russell <rusty@rustcorp.com.au>,
        matthew@hairy.beasts.org, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Re: futex and timeouts
Message-ID: <20020315192818.R4836@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>, matthew@hairy.beasts.org,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <20020314151846.EDCBF3FE07@smtp.linux.ibm.com> <20020315151507.2370C3FE0C@smtp.linux.ibm.com> <20020315160444.P4836@parcelfarce.linux.theplanet.co.uk> <20020315185844.8883E3FE06@smtp.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020315185844.8883E3FE06@smtp.linux.ibm.com>; from frankeh@watson.ibm.com on Fri, Mar 15, 2002 at 01:59:38PM -0500
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 01:59:38PM -0500, Hubertus Franke wrote:
> > > What I would like to see is an interface that lets me pass optional
> > > parameters to the syscall interface, so I can call with different number
> > > of parameters.
> >
> > 	Is this to lock multiple futexes "atomically"?  If we are
> > looking for a fast path stack-wise, this seems extra work.
> 
> No, take for example...
> 
> syscall3(int,futex,int,op, struct futex*, futex, int opt_arg);

	Oh, I totally misparsed your statement.  I thought you meant you
wanted a vararg sys_futex(), not a smarter _syscall() :-)

Joel

-- 

Life's Little Instruction Book #347

	"Never waste the oppourtunity to tell someone you love them."

			http://www.jlbec.org/
			jlbec@evilplan.org
