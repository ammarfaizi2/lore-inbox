Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUCXQzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 11:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbUCXQzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 11:55:39 -0500
Received: from mx.deam.org ([195.24.105.112]:275 "EHLO mx.deam.org")
	by vger.kernel.org with ESMTP id S263769AbUCXQzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 11:55:36 -0500
In-Reply-To: <Pine.LNX.4.44.0403131238120.19494-100000@dmt.cyclades>
References: <Pine.LNX.4.44.0403131238120.19494-100000@dmt.cyclades>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C161B40C-7DB3-11D8-B311-000A9575DB74@deam.org>
Content-Transfer-Encoding: 7bit
Cc: <andrea@suse.de>, <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       <mingo@redhat.com>
From: "Klaus M. Brantl" <kmb@deam.org>
Subject: Re: bug-report about a stability-problem with highmem and nfs
Date: Wed, 24 Mar 2004 17:53:20 +0100
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

dear marcelo,

On 13.03.2004, at 16:52, Marcelo Tosatti wrote:

we finally had some time today to get the serial-console up and running 
with another test.

> Can you please plug in a serial cable, turn the NMI oopser on
> (Documentation/nmi_watchdog.txt), and rerun the tests with 6GB to crash
> the box? This should get us an output of what is happening.

the problem is: there was no output. really nothing.
we tried it two times but there was nothing on the serial console like 
there is nothing on the main output.

the only additional info that i can give is the behaviour of the 
ssh-service:
1. i am logged in to the server.
2. the crash is indicated with the stop of any output.
3. you cannot connect anymore.
4. if you try a "telnet server 22" you receive the ssh-greeting.
5. after around a minute or so even the telnet to port 22 won't 
establish a connection.
then finally the server is 100% gone.

without any trace of information in the local logfiles or on the screen.


is there some "hardware-way" that we could try?
i am sure that i can bring my superior to some point of investing/ 
lending something to figure out more. it's also possible that we can 
ask compaq about this, but it might not be very successful, because 
they officially support only specific distributions and dist-kernels.

with regards
klaus m. brantl
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (Darwin)

iD8DBQFAYb0CvkHn/oGTPXURAiq6AKC5EniyZVybaqnMOoEbAAE6V/ITgwCghlm/
ByBt0ijczuORDbbAacLiLJo=
=o2MY
-----END PGP SIGNATURE-----

