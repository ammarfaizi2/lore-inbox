Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVDZLtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVDZLtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 07:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVDZLtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 07:49:05 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:5803 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261452AbVDZLs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 07:48:59 -0400
Date: Tue, 26 Apr 2005 13:48:04 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: 7eggert@gmx.de, akpm@osdl.org, Jan Hudec <bulb@ucw.cz>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Miklos Szeredi <miklos@szeredi.hu>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] private mounts
In-Reply-To: <OF9C5A2A1D.78873E27-ON88256FEE.00683441-88256FEE.00688DC9@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0504261347110.4555@be1.lrz>
References: <OF9C5A2A1D.78873E27-ON88256FEE.00683441-88256FEE.00688DC9@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005, Bryan Henderson wrote:

> >mknamespace -p users/$UID # (like mkdir -p)
> >setnamespace users/$UID   # (like cd)
>        ^^^^^^^^
> 
> You realize that 'cd' is a shell command, and has to be, I hope.  That 
> little fact has thrown a wrench into many of the ideas in this thread.

I suppose it will be called by the login process or by wrappers like 
'nice'.
-- 
Never stand when you can sit, never sit when you can lie down, never stay
awake when you can sleep.
