Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264033AbRFEQUr>; Tue, 5 Jun 2001 12:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264037AbRFEQUi>; Tue, 5 Jun 2001 12:20:38 -0400
Received: from mx2out.umbc.edu ([130.85.253.52]:29371 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S264034AbRFEQU1>;
	Tue, 5 Jun 2001 12:20:27 -0400
Date: Tue, 5 Jun 2001 12:20:25 -0400
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>, <kdb@oss.sgi.com>
Subject: Re: strange network hangs using kdb 
In-Reply-To: <18623.991756548@ocs3.ocs-net>
Message-ID: <Pine.SGI.4.31L.02.0106051217130.11523908-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Keith Owens wrote:

> On Tue, 5 Jun 2001 11:20:26 -0400,
> John Jasen <jjasen1@umbc.edu> wrote:
> >When we use kdb on one of the systems, the other system stops receiving
> >packets.
>
> man linux/Documentation/kdb/kdb.mm, section Interrupts and KDB.

I would expect one system to fall off the network, when it is put into
kdb. However, why does it have any effect on the other system, which may
or may not be in kdb?

Let's say we have two test servers (A and B); and four test clients (1-4).
1 and 2 are being used to test performance on A, while 3 and 4 are being
inflicted on B.

kdb is activated on A, and from that moment, no network traffic passes
between B and its clients, 3 and 4.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

