Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbSLBS4T>; Mon, 2 Dec 2002 13:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264872AbSLBS4T>; Mon, 2 Dec 2002 13:56:19 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:43731 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S264863AbSLBS4S>; Mon, 2 Dec 2002 13:56:18 -0500
Date: Mon, 2 Dec 2002 14:03:47 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Possible Module Loader bug...
In-Reply-To: <20021202233050.66669be9.neokeats@wanadoo.fr>
Message-ID: <Pine.GSO.4.33.0212021356370.6708-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2002, Keats wrote:
>Kernel version : 2.5.50
>lsmod
>QM_MODULES: function not implemented
...

Perhaps it would be a better idea to have the syscall vectors for the old
module functions do something other than simply return as not implemented.
Something along the lines of "(foo) attempted to use old module interface"
instead of simply deleting the functions entirely.

Otherwise, there are going to be 10 million people asking why modules don't
work anymore.  There is exactly ZERO indication that things have changed.
(The changes to the keyboard and pc speaker "beep" will have people confused
 as well.)

--Ricky


