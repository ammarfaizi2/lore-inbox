Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSGNQqx>; Sun, 14 Jul 2002 12:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316912AbSGNQqw>; Sun, 14 Jul 2002 12:46:52 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:13835 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316213AbSGNQqw>;
	Sun, 14 Jul 2002 12:46:52 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207141649.g6EGndc140138@saturn.cs.uml.edu>
Subject: Re: Advice saught on math functions
To: pashley@storm.ca (Sandy Harris)
Date: Sun, 14 Jul 2002 12:49:39 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D3187E6.426BB595@storm.ca> from "Sandy Harris" at Jul 14, 2002 10:17:10 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sandy Harris writes:
> Erik Andersen wrote:

>> This is kernel space.  Using any math functions is forbidden
>> in kernel space,
>
> Exactly what do you mean by "forbidden"?

You will corrupt the FPU registers of a user app and/or
cause an oops, assuming the kernel compiles at all.
