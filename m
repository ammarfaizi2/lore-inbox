Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288394AbSACXka>; Thu, 3 Jan 2002 18:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288393AbSACXkT>; Thu, 3 Jan 2002 18:40:19 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:14084 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288392AbSACXkK>;
	Thu, 3 Jan 2002 18:40:10 -0500
Date: Thu, 3 Jan 2002 19:55:10 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: corbet@lwn.net (Jonathan Corbet)
Cc: Michael Zhu <mylinuxk@yahoo.ca>, linux-kernel@vger.kernel.org
Subject: Re: The CURRENT macro
Message-ID: <20020103195509.C26824@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	corbet@lwn.net (Jonathan Corbet), Michael Zhu <mylinuxk@yahoo.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020103213455.34699.qmail@web14911.mail.yahoo.com> <20020103214839.9953.qmail@eklektix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020103214839.9953.qmail@eklektix.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 03, 2002 at 02:48:39PM -0700, Jonathan Corbet escreveu:
> > In Alessandro Rubini's book Linux Device Driver(Second
> > Edition), Chatper 12

> Alessandro and...um...some other guy...:)

Yes, I know that other guy, very nice guy indeed 8)
 
> > he said that "By accessing the
> > fields in the request structure, usually by way of
> > CURRENT" and "CURRENT is just a pointer into
> > blk_dev[MAJOR_NR].request_queue". I know CURRENT is
> > just a macro. Where can I find the definition of this
> > macro?
 
> A little grepping in the source would give you the answer there.  It's in
> .../include/linux/blk.h.  

Or:

make tags
vi -t CURRENT 

8)

- Arnaldo
