Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318131AbSHZVX5>; Mon, 26 Aug 2002 17:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318148AbSHZVX5>; Mon, 26 Aug 2002 17:23:57 -0400
Received: from mnh-1-13.mv.com ([207.22.10.45]:27653 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S318131AbSHZVX5>;
	Mon, 26 Aug 2002 17:23:57 -0400
Message-Id: <200208262231.RAA04222@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: copy_to_user to a kmapped address 
In-Reply-To: Your message of "Mon, 26 Aug 2002 21:33:04 +0100."
             <20020826213304.I4763@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Aug 2002 17:31:23 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmk@arm.linux.org.uk said:
> Umm, that's copying from kaddr + offset _to_ desc->buf.  desc->buf
> should be the user space address, and kaddr + offset a kernel address:

Duh, nevermind...

				Jeff



