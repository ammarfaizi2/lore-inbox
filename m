Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316951AbSHNL7m>; Wed, 14 Aug 2002 07:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317003AbSHNL7m>; Wed, 14 Aug 2002 07:59:42 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1775 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316951AbSHNL7m> convert rfc822-to-8bit; Wed, 14 Aug 2002 07:59:42 -0400
Subject: Re: can't use 2.4 on my 486 server
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020814103544.GA1018@darkwood.localdomain>
References: <20020814103544.GA1018@darkwood.localdomain>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Aug 2002 13:01:32 +0100
Message-Id: <1029326492.26226.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-14 at 11:35, Jacek Pop³awski wrote:
> I use 2.4 kernel for a long time on my workstations, but can't use it on old
> 486 server with 16MB RAM. 2.2 works there without problems (for a long time).
> But few hours after running 2.4.19 server is unreachable. When I connect
> monitor/keyboard and start it again I see fsck starting then:

Two things to check first:  The memory (we've seen 2.4 find bad ram bugs
2.2 did not) and also that its getting the memory size right. 2.4 uses
E820 then E801 memory sizing, older 2.2 (< 2.2.18 or so) didnt do this.
So far I only know of one box that gets memory size wrong just with
E820.

Finally what is plugged into it ?

