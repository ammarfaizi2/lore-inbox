Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264036AbRFEQim>; Tue, 5 Jun 2001 12:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264039AbRFEQib>; Tue, 5 Jun 2001 12:38:31 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:20741 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264037AbRFEQiS>;
	Tue, 5 Jun 2001 12:38:18 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: John Jasen <jjasen1@umbc.edu>
cc: linux-kernel@vger.kernel.org, kdb@oss.sgi.com
Subject: Re: strange network hangs using kdb 
In-Reply-To: Your message of "Tue, 05 Jun 2001 12:20:25 -0400."
             <Pine.SGI.4.31L.02.0106051217130.11523908-100000@irix2.gl.umbc.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Jun 2001 02:38:08 +1000
Message-ID: <19199.991759088@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001 12:20:25 -0400, 
John Jasen <jjasen1@umbc.edu> wrote:
>On Wed, 6 Jun 2001, Keith Owens wrote:
>> On Tue, 5 Jun 2001 11:20:26 -0400,
>> John Jasen <jjasen1@umbc.edu> wrote:
>> >When we use kdb on one of the systems, the other system stops receiving
>> >packets.
>>
>> man linux/Documentation/kdb/kdb.mm, section Interrupts and KDB.
>
>I would expect one system to fall off the network, when it is put into
>kdb. However, why does it have any effect on the other system, which may
>or may not be in kdb?

It does not.  kdb is intrusive when it trips but even it cannot reach
across a network and stop another machine.  Look for a networking
problem on the other system.

