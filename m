Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbTAUSzt>; Tue, 21 Jan 2003 13:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267199AbTAUSzs>; Tue, 21 Jan 2003 13:55:48 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:32017 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267200AbTAUSzr>;
	Tue, 21 Jan 2003 13:55:47 -0500
Date: Tue, 21 Jan 2003 20:04:48 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [PATCH (take 2)][2.5] hangcheck-timer
Message-ID: <20030121190448.GB1261@mars.ravnborg.org>
Mail-Followup-To: Joel Becker <Joel.Becker@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Wim Coekaerts <Wim.Coekaerts@oracle.com>
References: <20030121011954.GO20972@ca-server1.us.oracle.com> <20030121081158.A21080@infradead.org> <20030121173303.GU20972@ca-server1.us.oracle.com> <20030121184403.GY20972@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030121184403.GY20972@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 10:44:04AM -0800, Joel Becker wrote:
> 	Updated with suggested fixes.
> 
> Joel
> 
> diff -uNr linux-2.5.59/drivers/char/Kconfig linux-2.5.59-hangcheck/drivers/char/Kconfig
> --- linux-2.5.59/drivers/char/Kconfig	Thu Jan 16 18:21:36 2003
> +++ linux-2.5.59-hangcheck/drivers/char/Kconfig	Mon Jan 20 13:35:27 2003
> @@ -992,5 +992,8 @@
>  	  Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O. 
>  	  See the raw(8) manpage for more details.
>  
> +config HANGCHECK_TIMER
> +	tristate "Hangcheck timer"
> +
>  endmenu

Help entry missing...

	Sam
