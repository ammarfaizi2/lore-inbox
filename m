Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319070AbSHMUsg>; Tue, 13 Aug 2002 16:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319071AbSHMUsf>; Tue, 13 Aug 2002 16:48:35 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:28613 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319070AbSHMUs2>;
	Tue, 13 Aug 2002 16:48:28 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15705.29059.306202.720523@napali.hpl.hp.com>
Date: Tue, 13 Aug 2002 13:52:19 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] clone_startup(), 2.5.31-A0
In-Reply-To: <3D596B96.4000305@zytor.com>
References: <Pine.LNX.4.44.0208131650230.30647-100000@localhost.localdomain>
	<20020813160924.GA3821@codepoet.org>
	<20020813171138.A12546@infradead.org>
	<15705.13490.713278.815154@napali.hpl.hp.com>
	<ajbo1b$e2a$1@cesium.transmeta.com>
	<15705.27073.997831.983519@napali.hpl.hp.com>
	<3D596B96.4000305@zytor.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 13 Aug 2002 13:27:02 -0700, "H. Peter Anvin" <hpa@zytor.com> said:

  >> I was, however, the flaws that you complained of had nothing to
  >> do with the syscall -- it's all in the syscall wrapper (which is
  >> required for clone(), like it or not.)

The issue is not whether a wrapper is needed or not.

My point is that it is cleaner to always describe stack areas as
memory areas (e.g., as a base/size pair).  Note that this is
effectively what's happening in the platform-independent part of the
kernel today.

	--david
