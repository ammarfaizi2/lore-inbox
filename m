Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313047AbSDEQYf>; Fri, 5 Apr 2002 11:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313050AbSDEQYP>; Fri, 5 Apr 2002 11:24:15 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:44183 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S313047AbSDEQYG>; Fri, 5 Apr 2002 11:24:06 -0500
Date: Fri, 5 Apr 2002 18:24:07 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Martin Mares <mj@ucw.cz>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, pic 16 4/9
In-Reply-To: <20020405105911.GA3116@ucw.cz>
Message-ID: <Pine.GSO.3.96.1020405181548.25048D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, Martin Mares wrote:

> For such purposes, it would be wonderful if somebody could teach gas
> how to assemble absolute code and make real location of code and base
> for calculation of symbols independent. It probably could be done with
> sections and a cleverly written ldscript (modulo ld bugs), but it's
> nowhere near elegant.

 The location of code is already independent from symbol addresses.  The
default location is identity-mapped to addresses but that can be changed.
You normally do that by setting a different LMA in a linker script with
the "AT" keyword. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

