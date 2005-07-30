Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262980AbVG3PU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbVG3PU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 11:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbVG3PU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 11:20:56 -0400
Received: from 66-189-87-63.static.oxfr.ma.charter.com ([66.189.87.63]:39182
	"EHLO lakshmi.solana.com") by vger.kernel.org with ESMTP
	id S262980AbVG3PUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 11:20:54 -0400
Date: Sat, 30 Jul 2005 11:14:32 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Willem de Bruijn <wdb@few.vu.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: status of kernel memory debugging?
Message-ID: <20050730151432.GA3524@ccure.user-mode-linux.org>
References: <200507301323.28083.wdb@few.vu.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507301323.28083.wdb@few.vu.nl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 01:23:27PM +0200, Willem de Bruijn wrote:
> Reading through some old LKML threads I see that there has been talk of 
> valgrinding a UML image, but the outcome appears inconclusive. Could someone 
> please update me on the status of memory debugging in the kernel, especially 
> regarding valgrind?

UML is still too strange for valgrind, despite progress on both sides
(valgrind accepting more strange things and UML becoming less
strange).  

I tried grinding UML a month or so ago, and its use of clone was a
sticking point.

				Jeff
