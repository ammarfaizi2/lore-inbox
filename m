Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWFVU7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWFVU7E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWFVU7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:59:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46023 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964842AbWFVU7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:59:00 -0400
Date: Thu, 22 Jun 2006 22:58:59 +0200
From: Petr Baudis <pasky@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Junio C Hamano <junkio@cox.net>,
       Johannes Schindelin <Johannes.Schindelin@gmx.de>,
       Git Mailing List <git@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
Message-ID: <20060622205859.GF21864@pasky.or.cz>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Thu, Jun 22, 2006 at 10:53:31PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> So in order to avoid a lot of blind git users, please apply this patch.

Great, since this also seems to make git diff more or less consistent
with cg diff in the colors choice.

>  enum color_diff {
> -	DIFF_PLAIN = 0,
> -	DIFF_METAINFO = 1,
> -	DIFF_FILE_OLD = 2,
> -	DIFF_FILE_NEW = 3,
> +	DIFF_RESET = 0,
> +	DIFF_PLAIN = 1,
> +	DIFF_METAINFO = 2,
> +	DIFF_FRAGINFO = 3,
> +	DIFF_FILE_OLD = 4,
> +	DIFF_FILE_NEW = 5,
>  };

Isn't manually numbering the enum choices somewhat pointless, though?
(Actually makes it more difficult to do changes in it later.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
