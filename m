Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272407AbTHEKco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 06:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272478AbTHEKco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 06:32:44 -0400
Received: from mail.gondor.com ([212.117.64.182]:44562 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S272407AbTHEKco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 06:32:44 -0400
Date: Tue, 5 Aug 2003 12:32:41 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Patrick Moor <pmoor@netpeople.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: time jumps (again)
Message-ID: <20030805103241.GA29636@gondor.com>
References: <3F2E8B3B.3070003@netpeople.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2E8B3B.3070003@netpeople.ch>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 06:35:07PM +0200, Patrick Moor wrote:
> I'm noticing time jumps _exactly_ at the beginning of a "new" second (or 
> at the end of an "old" one). the jump is exactly 4294 (4295) seconds 
> into the future. Example:

We had the same problem with a similar setup (ASUS board, VIA chipset,
AMD CPU). 

The solution is in the following thread, and AFAIK the patch went into
2.4.21:
http://www.ussg.iu.edu/hypermail/linux/kernel/0211.0/0330.html

Jan

