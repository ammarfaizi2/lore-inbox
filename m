Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWAESEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWAESEk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWAESEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:04:39 -0500
Received: from c-67-174-241-67.hsd1.ca.comcast.net ([67.174.241.67]:49827 "EHLO
	plato.virtuousgeek.org") by vger.kernel.org with ESMTP
	id S932117AbWAESEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:04:38 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
Date: Thu, 5 Jan 2006 10:04:31 -0800
User-Agent: KMail/1.9
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Nicolas Pitre <nico@cam.org>, Joel Schopp <jschopp@austin.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
References: <20060104144151.GA27646@elte.hu> <43BC90CE.4040201@yahoo.com.au> <20060105033951.GD10140@krispykreme>
In-Reply-To: <20060105033951.GD10140@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051004.31449.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, January 4, 2006 7:39 pm, Anton Blanchard wrote:
> SGIs mmiowb() might be useful for some of these cases but every time
> its brought up everyone ends up confused as to its real use.

It's documented in Documentation/DocBook/deviceiobook.tmpl.  If the 
documentation isn't clear, we should fix it, rather than avoid using the 
primitive altogether.  If drivers/net really means mmiowb() in some 
places, we should change it, and like you said maybe get rid of some of 
these primitives so that their usage is clearer.

Jesse
