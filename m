Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318017AbSGRGbl>; Thu, 18 Jul 2002 02:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318018AbSGRGbl>; Thu, 18 Jul 2002 02:31:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49170 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318017AbSGRGbk>; Thu, 18 Jul 2002 02:31:40 -0400
Message-ID: <3D366103.8010403@zytor.com>
Date: Wed, 17 Jul 2002 23:32:35 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, viro@math.psu.edu,
       trond.myklebust@fys.uio.no, Matija Nalis <mnalis-umsdos@voyager.hr>,
       aia21@cantab.net, al@alarsen.net, asun@cobaltnet.com,
       bfennema@falcon.csc.calpoly.edu, dave@trylinux.com, braam@clusterfs.com,
       chaffee@cs.berkeley.edu, dwmw2@infradead.org, eric@andante.org,
       hch@infradead.org, jaharkes@cs.cmu.edu, jakub@redhat.com,
       jffs-dev@axis.com, mikulas@artax.karlin.mff.cuni.cz,
       quinlan@transmeta.com, reiserfs-dev@namesys.com,
       Chris Mason <mason@suse.com>, rgooch@atnf.csiro.au,
       rmk@arm.linux.org.uk, shaggy@austin.ibm.com, tigran@veritas.com,
       urban@teststation.com, vandrove@vc.cvut.cz, vl@kki.org,
       zippel@linux-m68k.org, Art Haas <ahaas@neosoft.com>
Subject: Re: Remain Calm: Designated initializer patches for 2.5
References: <20020718032331.5A36644A8@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
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

As far as I could tell, *ALL* of these changes broke text alignment in 
columns.  It would have been a lot better if they had maintained 
spacing; I find the new code much more cluttered and hard to read.

	-hpa


