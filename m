Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319014AbSHMUPY>; Tue, 13 Aug 2002 16:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319015AbSHMUPY>; Tue, 13 Aug 2002 16:15:24 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:10186 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319014AbSHMUPX>;
	Tue, 13 Aug 2002 16:15:23 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15705.27073.997831.983519@napali.hpl.hp.com>
Date: Tue, 13 Aug 2002 13:19:13 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] clone_startup(), 2.5.31-A0
In-Reply-To: <ajbo1b$e2a$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0208131650230.30647-100000@localhost.localdomain>
	<20020813160924.GA3821@codepoet.org>
	<20020813171138.A12546@infradead.org>
	<15705.13490.713278.815154@napali.hpl.hp.com>
	<ajbo1b$e2a$1@cesium.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 13 Aug 2002 12:52:11 -0700, "H. Peter Anvin" <hpa@zytor.com> said:

  >> The clone() system call cannot be used by portable applications
  >> *AT ALL*, since it inherently needs a user-space assembly
  >> wrapper.  It's just a matter of how you define the interface to
  >> the assembly wrapper.

The function call issue is a separate question though.  If you want to
argue that the libc clone() wrapper is broken, fine by me.  (BTW:
wasn't that you who complained about platform-specific Linux syscalls
recently? ;-)

	--david
