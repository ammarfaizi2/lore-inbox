Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVFXGtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVFXGtW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 02:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVFXGtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 02:49:22 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:58580 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262623AbVFXGtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 02:49:17 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git patch] urgent e1000 fix
Date: Fri, 24 Jun 2005 09:49:05 +0300
User-Agent: KMail/1.5.4
Cc: David Lang <david.lang@digitalinsight.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
References: <42BA7FB5.5020804@pobox.com> <42BB4172.5000904@pobox.com> <Pine.LNX.4.58.0506231625310.11175@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506231625310.11175@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506240949.05620.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 June 2005 02:33, Linus Torvalds wrote:
> To actually allow real fuzz or to allow real whitespace differences in the
> patch data itself is a _much_ bigger issue than this trivial patch
> corruption, and I'd prefer to avoid going there if at all possible.

How about automatic stripping of _trailing_ whitespace on all incoming
patches? IIRC no file type (C, sh, Makefile, you name it) depends on
conservation of it, thus it's 100% safe.
--
vda

