Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285570AbRLTAhi>; Wed, 19 Dec 2001 19:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285704AbRLTAhT>; Wed, 19 Dec 2001 19:37:19 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:52997 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285570AbRLTAhF>; Wed, 19 Dec 2001 19:37:05 -0500
Message-ID: <3C213270.966DABFE@zip.com.au>
Date: Wed, 19 Dec 2001 16:36:00 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
In-Reply-To: <E16Gjuw-0000UT-00@starship.berlin> <Pine.LNX.4.33.0112190859050.1872-100000@penguin.transmeta.com> <20011219135708.A12608@devserv.devel.redhat.com> <20011219.161359.71089731.davem@redhat.com>,
		<20011219.161359.71089731.davem@redhat.com>; from davem@redhat.com on Wed, Dec 19, 2001 at 04:13:59PM -0800 <20011219192136.F2034@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> All I need is a set of syscall numbers that aren't going to change
> should this implementation stand up to the test of time.

The aio_* functions are part of POSIX and SUS, so merely reserving
system call numbers for them does not seems a completely dumb
thing to do, IMO.

-
