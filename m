Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287212AbSAGVvC>; Mon, 7 Jan 2002 16:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287204AbSAGVuq>; Mon, 7 Jan 2002 16:50:46 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:59658 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S287200AbSAGVud>; Mon, 7 Jan 2002 16:50:33 -0500
Date: Mon, 7 Jan 2002 19:49:27 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, torvalds@transmeta.com,
        viro@math.psu.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Message-ID: <20020107214925.GH1026@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Daniel Phillips <phillips@bonn-fries.net>, torvalds@transmeta.com,
	viro@math.psu.edu, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20020107132121.241311F6A@gtf.org> <E16NcLw-0001R9-00@starship.berlin> <3C3A13F8.33BABD62@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3A13F8.33BABD62@mandrakesoft.com>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 07, 2002 at 04:32:40PM -0500, Jeff Garzik escreveu:
> I am very much interested in a better solution...  I could not figure
> out how to get a private pointer from a struct inode*, without using a
> nasty OFFSET_OF macro or a pointer to self as I implemented.

Why nasty, don't you like the list_head macros? 8) BTW, thats how Linus
suggested it to be done in private conversation. Look at list_entry.

- Arnaldo
