Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWCaN3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWCaN3V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 08:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWCaN3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 08:29:20 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:47372 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932075AbWCaN3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 08:29:20 -0500
Date: Fri, 31 Mar 2006 15:28:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice exports
Message-ID: <20060331132856.GA12208@mars.ravnborg.org>
References: <20060331040613.GA23511@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331040613.GA23511@havoc.gtf.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 11:06:13PM -0500, Jeff Garzik wrote:
  /*
>   * Passed to the actors
> @@ -567,6 +568,9 @@ ssize_t generic_splice_sendpage(struct i
>  	return move_from_pipe(inode, out, len, flags, pipe_to_sendpage);
>  }
>  
> +EXPORT_SYMBOL(generic_file_splice_write);
> +EXPORT_SYMBOL(generic_file_splice_read);
Can we please have them right after the closing brace of the function
defining these function instead.

	Sam
