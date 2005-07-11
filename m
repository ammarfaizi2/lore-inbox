Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVGKKNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVGKKNN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 06:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVGKKNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 06:13:13 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:57122 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261554AbVGKKMe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 06:12:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iuV7R7ufxaFDW8L6lEfMM9+VvWu41UuJr+upSVonnHwqN0fWwrm9yzg1gFmeLn30dNqbE3E4fCpA4sSk8v0fzgJwiVLKkd+qg0Cuivohq+b5MzMNwRSsU0o5F0KDh/edjx9WIhy1flfNGZHpmpKzxXK9VlGsAKYqfFGs2HSeEfk=
Message-ID: <fc339e4a050711031222c4c0b5@mail.gmail.com>
Date: Mon, 11 Jul 2005 19:12:34 +0900
From: Miles Bader <snogglethorpe@gmail.com>
Reply-To: snogglethorpe@gmail.com, miles@gnu.org
To: Miles Bader <miles@gnu.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v850: Update checksum.h to match changed function signatures
In-Reply-To: <20050711094151.GA31805@gilgamesh.home.res>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050711092450.52815625@mctpc71>
	 <20050711094151.GA31805@gilgamesh.home.res>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/7/11, Frederik Deweerdt <frederik.deweerdt@gmail.com>:
> > -unsigned int csum_partial_copy_from_user (const unsigned char *src, unsigned char *dst,
> > +unsigned int csum_partial_copy_from_user (const unsigned char *src,
> > +                                       unsigned char *dst,
>                                           ^^^^^^^ Alignment looks fuzzy here

It's actually a spaces-vs-tabs issue -- the existing lines use all
spaces for indentation, but my new line uses tabs, so when viewed as
part of the diff they look unaligned; they look OK in the actual
source file though.

-Miles
-- 
Do not taunt Happy Fun Ball.
