Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266240AbUHHTzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUHHTzi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 15:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUHHTzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 15:55:37 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:45158 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266240AbUHHTxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 15:53:35 -0400
Date: Sun, 8 Aug 2004 21:55:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: highmem handling again
Message-ID: <20040808195529.GF22610@mars.ravnborg.org>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@digitalimplant.org>
References: <20040808192300.GA659@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040808192300.GA659@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 09:23:00PM +0200, Pavel Machek wrote:
>  		}
> -	} else
> +	} else {
> +		extern int restore_highmem(void);
> +		restore_highmem();

Prototype in .h files...

	Sam
