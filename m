Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbTDXM6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 08:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbTDXM6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 08:58:44 -0400
Received: from mail.ithnet.com ([217.64.64.8]:32269 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261405AbTDXM6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 08:58:43 -0400
Date: Thu, 24 Apr 2003 15:10:21 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: daw@mozart.cs.berkeley.edu (David Wagner)
Cc: frodoid@frodoid.org, rml@tech9.net, frodo@dereference.de,
       linux-kernel@vger.kernel.org, wa@almesberger.net
Subject: Re: kernel ring buffer accessible by users
Message-Id: <20030424151021.69b34400.skraw@ithnet.com>
In-Reply-To: <b87b8q$sks$3@abraham.cs.berkeley.edu>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org>
	<1051031876.707.804.camel@localhost>
	<20030423125602.B1425@almesberger.net>
	<20030423160556.GA30306@frodo.midearth.frodoid.org>
	<b87b8q$sks$3@abraham.cs.berkeley.edu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Apr 2003 00:31:22 GMT
daw@mozart.cs.berkeley.edu (David Wagner) wrote:

> Julien Oster wrote:
> >Of course one could say "then let's just stop writing out anything in
> >the kernel buffer that COULD be sensitive", but I think this would
> >actually castrate the meaning of such a buffer.
> 
> Would it?  I can't think of anything that currently should be printed
> to the ring buffer and is known to be secret.

The simple truth is: you cannot really qualify what a "secret" is or is not. It
depends on the _reader_(s' interest), not the _writer_ (s' intention). 

Regards,
Stephan
