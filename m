Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVAIFPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVAIFPH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 00:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVAIFPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 00:15:07 -0500
Received: from mx.freeshell.org ([192.94.73.21]:48589 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S262253AbVAIFPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 00:15:03 -0500
Date: Sun, 9 Jan 2005 05:14:55 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
In-Reply-To: <d120d50005010707204463492@mail.gmail.com>
Message-ID: <Pine.NEB.4.61.0501090513180.18441@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> 
 <200501052316.48443.dtor_core@ameritech.net>  <Pine.NEB.4.61.0501070405170.2840@sdf.lonestar.org>
  <200501070045.24639.dtor_core@ameritech.net>  <Pine.NEB.4.61.0501071336010.23626@sdf.lonestar.org>
 <d120d50005010707204463492@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

maybe I'm misunderstanding you;  how should the file look like once I 
modify it with your changes (what does "reversing the fragment" mean 
here)?

On Fri, 7 Jan 2005, Dmitry Torokhov wrote:

> Ok, so the timeouts are here even with good version. Hmm...
>
> Ok, one thing is that in -bk3 I moved i8042 initialization earlier,
> could you try reversing the fragment below (it is cut and paste so
> patch won't work, you'll have to move that line manually). And touch
> i8042.c to force rebuild.
>
> If this does not work try disabling psmouse - does it help with the keyboard?
>
