Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262227AbSJNXb2>; Mon, 14 Oct 2002 19:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSJNXb2>; Mon, 14 Oct 2002 19:31:28 -0400
Received: from franka.aracnet.com ([216.99.193.44]:21896 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262227AbSJNXb1>; Mon, 14 Oct 2002 19:31:27 -0400
Date: Mon, 14 Oct 2002 16:35:12 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Summit support for 2.5 - now with subarch! [4/5]
Message-ID: <2001880782.1034613312@[10.10.2.3]>
In-Reply-To: <200210142311.g9ENB9m04835@localhost.localdomain>
References: <200210142311.g9ENB9m04835@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +       summit_check(oem, str);
> 
> This is more a type check hook.  Since it might potentially be used to catch 
> other machine types, shouldn't it have a more generic name 
> (mptable_string_hook or something)?

OK, I can change that.

>> +int summit_x86 = 0;
> 
> This should really be in a .c file in mach-summit.  I know a single line file 
> with just a variable in it is a bit strange, but the principle of the subarch 
> stuff is to have anything subarch specific (which this is) in mach-<subarch>.

That's pretty pointless for one variable. I think you're taking things
to ridiculous extremes.

M.


