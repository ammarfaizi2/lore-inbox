Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAIRSM>; Tue, 9 Jan 2001 12:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAIRSC>; Tue, 9 Jan 2001 12:18:02 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:32764 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129383AbRAIRR6>; Tue, 9 Jan 2001 12:17:58 -0500
Date: Tue, 9 Jan 2001 13:30:19 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dn_keyb.c: restore_flags on failure
Message-ID: <20010109133019.S21057@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010109113837.P21057@conectiva.com.br> <E14G1Sm-0006t5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14G1Sm-0006t5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jan 09, 2001 at 04:17:30PM +0000
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 09, 2001 at 04:17:30PM +0000, Alan Cox escreveu:
> >  		keyb_cmds[keyb_cmd_write++]=*(cmd++);
> >  		if(keyb_cmd_write==keyb_cmd_read)
> > -			return;
> ># +			goto out;
> 
> Hans Grobler beat you to this one

Ok, I'll talk with him in private to have a proper janitor union, avoiding
duplicate work, I'll talk with Panin too 8)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
