Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRC0KIN>; Tue, 27 Mar 2001 05:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131171AbRC0KIE>; Tue, 27 Mar 2001 05:08:04 -0500
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:32940
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S131079AbRC0KHv>; Tue, 27 Mar 2001 05:07:51 -0500
Message-ID: <3AC06651.1ECB7B5@math.ethz.ch>
Date: Tue, 27 Mar 2001 12:07:13 +0200
From: Giacomo Catenazzi <cate@math.ethz.ch>
Reply-To: cate@dplanet.ch
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: manfred@colorfullife.com
CC: puckwork@madz.net, linux-kernel@vger.kernel.org
Subject: Re: URGENT : System hands on "Freeing unused kernel memory: "
In-Reply-To: <fa.it9nv9v.g08l8a@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Studierende der Universitaet des Saarlandes wrote:
> 
> I have 2 ideas:
> * glibc corrupted
> * did you downgrade the cpu?

These happen frequently to me (when compiling and installing a
new glibc)
But in this case you would have other messages (IIRC something
like
respawn too fast).
Thus the problem is not this!


Possible problem:

1) permition of /sbin/init
2) unable to exec ELF binary (or a.out, which init do you
have?)
3) problems with the root partition. (check it with an
emergency disk)
4) once I had strange problem with init and /dev (init was
continuosly
killed, but after some init.d scripts). Check your /dev/


	giacomo
