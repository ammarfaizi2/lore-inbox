Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263230AbTDCAjx>; Wed, 2 Apr 2003 19:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263234AbTDCAjx>; Wed, 2 Apr 2003 19:39:53 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:32477 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263230AbTDCAjw>; Wed, 2 Apr 2003 19:39:52 -0500
Date: Wed, 2 Apr 2003 16:53:44 -0800
From: Greg KH <greg@kroah.com>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB Mouse issue
Message-ID: <20030403005344.GA5361@kroah.com>
References: <20030402193731.GA1273@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030402193731.GA1273@DervishD>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 09:37:31PM +0200, DervishD wrote:
>     But when I do 'gpm -m mouse -p -t imps2' I have a 'ENODEV'. Same
> if I try to open 'mouse' with cat or the like, always ENODEV:
> 
>     crw-r--r--  1 root root 180,16 mouse

No, this interface (Major 180, minor 16) is long out of date.  You have
to use the input core now.

greg k-h
