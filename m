Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318002AbSGRDbi>; Wed, 17 Jul 2002 23:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318003AbSGRDbi>; Wed, 17 Jul 2002 23:31:38 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:16651 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318002AbSGRDbh>; Wed, 17 Jul 2002 23:31:37 -0400
Date: Thu, 18 Jul 2002 00:32:43 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu,
       trond.myklebust@fys.uio.no, Matija Nalis <mnalis-umsdos@voyager.hr>,
       aia21@cantab.net, al@alarsen.net, asun@cobaltnet.com,
       bfennema@falcon.csc.calpoly.edu, dave@trylinux.com, braam@clusterfs.com,
       chaffee@cs.berkeley.edu, dwmw2@infradead.org, eric@andante.org,
       hch@infradead.org, hpa@zytor.com, jaharkes@cs.cmu.edu, jakub@redhat.com,
       jffs-dev@axis.com, mikulas@artax.karlin.mff.cuni.cz,
       quinlan@transmeta.com, reiserfs-dev@namesys.com,
       Chris Mason <mason@suse.com>, rgooch@atnf.csiro.au,
       rmk@arm.linux.org.uk, shaggy@austin.ibm.com, tigran@veritas.com,
       urban@teststation.com, vandrove@vc.cvut.cz, vl@kki.org,
       zippel@linux-m68k.org, Art Haas <ahaas@neosoft.com>
Subject: Re: Remain Calm: Designated initializer patches for 2.5
Message-ID: <20020718033243.GA2031@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	viro@math.psu.edu, trond.myklebust@fys.uio.no,
	Matija Nalis <mnalis-umsdos@voyager.hr>, aia21@cantab.net,
	al@alarsen.net, asun@cobaltnet.com, bfennema@falcon.csc.calpoly.edu,
	dave@trylinux.com, braam@clusterfs.com, chaffee@cs.berkeley.edu,
	dwmw2@infradead.org, eric@andante.org, hch@infradead.org,
	hpa@zytor.com, jaharkes@cs.cmu.edu, jakub@redhat.com,
	jffs-dev@axis.com, mikulas@artax.karlin.mff.cuni.cz,
	quinlan@transmeta.com, reiserfs-dev@namesys.com,
	Chris Mason <mason@suse.com>, rgooch@atnf.csiro.au,
	rmk@arm.linux.org.uk, shaggy@austin.ibm.com, tigran@veritas.com,
	urban@teststation.com, vandrove@vc.cvut.cz, vl@kki.org,
	zippel@linux-m68k.org, Art Haas <ahaas@neosoft.com>
References: <20020718032331.5A36644A8@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020718032331.5A36644A8@lists.samba.org>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 18, 2002 at 01:22:23PM +1000, Rusty Russell escreveu:
> Hi all,
> 
> 	I just sent about 40 reasonable-size patches through the
> Trivial Patch Monkey to Linus: these patches replace the (deprecated)
> "foo: " designated initializers with the ISO-C ".foo =" initializers.
> GCC has understood both since forever, but the kernel took a wrong
> bet, and we're better off setting a good example for 2.6 before we
> start getting about 10,000 warnings.
> 
> 	So far, Art Haas has done all the fs code, and will presumably
> be working through the other code on dir at a time.
> 
> Just a heads-up,

Did this ones touched the net/{ipv4,ipv6,appletalk} dirs? I'm working on
general cleanups in those and this is one of the things I'm doing, again
just a heads up.

- Arnaldo

PS.: deliver_to_old_ones_users-- will happen for Appletalk 8)
