Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbSKAV3k>; Fri, 1 Nov 2002 16:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265759AbSKAV3k>; Fri, 1 Nov 2002 16:29:40 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:10758 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265754AbSKAV3j>;
	Fri, 1 Nov 2002 16:29:39 -0500
Date: Fri, 1 Nov 2002 13:32:59 -0800
From: Greg KH <greg@kroah.com>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: linux-2.4 cset 1.736.3.2 breaks USB hubs , deadlock
Message-ID: <20021101213259.GA18015@kroah.com>
References: <20021101222852.A5717@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101222852.A5717@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 10:28:52PM +0100, Olaf Hering wrote:
> What shoud this patch fix?
> 
> It locks up my iBook when attaching an Apple USB keyboard. Other people
> reported similar hangs.
> Please revert it or find a better solution for 2.4.20.

It's wrong and Marcelo said he would revert it.  Marcelo, do you want me
to make up a tree so that you can pull this change from?

thanks,

greg k-h
