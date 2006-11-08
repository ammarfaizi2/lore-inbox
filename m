Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754528AbWKHLXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbWKHLXU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 06:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbWKHLXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 06:23:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:61827 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1754528AbWKHLXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 06:23:19 -0500
Date: Wed, 8 Nov 2006 03:22:53 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061108032253.e4f4b0b5.pj@sgi.com>
In-Reply-To: <6599ad830611072015g48a7013r3e3aed1bf22e905d@mail.gmail.com>
References: <20061030031531.8c671815.pj@sgi.com>
	<6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	<20061101172540.GA8904@in.ibm.com>
	<6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	<20061106124948.GA3027@in.ibm.com>
	<6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
	<20061107104118.f02a1114.pj@sgi.com>
	<6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
	<6599ad830611071421s7792bbb1qd9c7b1fc840dfa50@mail.gmail.com>
	<20061107191518.c094ce1a.pj@sgi.com>
	<6599ad830611072015g48a7013r3e3aed1bf22e905d@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> except for the fact that I
> was trying to fit the controller/container bindings into the same
> mount/umount interface.

Of course, if you come up with an API using mount for this stuff
that looks nice and intuitive, don't hesitate to propose it.

I don't have any fundamental opposition to just using mount options
here; just a pretty strong guess that it won't be very intuitive
by the time all the necessary operations are encoded.

And this sort of abstractified pseudo meta containerized code is
just the sort of thing that drives normal humans up a wall, or
should I say, into a fog of confusion.

Not only is it worth a bit of work getting the abstractions right,
as you have noted, it's also worth a bit of work to try to get the
API as transparent as we are able.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
