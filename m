Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTLLXSw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 18:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTLLXSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 18:18:52 -0500
Received: from main.gmane.org ([80.91.224.249]:54953 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262740AbTLLXSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 18:18:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Increasing HZ (patch for HZ > 1000)
Date: Sat, 13 Dec 2003 00:18:48 +0100
Message-ID: <yw1xllphy693.fsf@kth.se>
References: <1071126929.5149.24.camel@idefix.homelinux.org> <1293500000.1071127099@[10.10.2.4]>
 <20031212220853.GA314@elf.ucw.cz>
 <1071269849.4182.14.camel@idefix.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:4cxYlqPBVzcVKnjt1S7faDQMefw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca> writes:

> more sensitive at 1 kHz). Also, I have around 10% overhead on my
> Pentium-M 1.6 GHz, so I guess it's not for everyone. Extrapolating from
> there, I'd also say that at 100 kHz, it wouldn't do anything but handle
> the interrupts, which is slightly annoying when you want to actually get
> some work done :)

I once forgot to acknowledge an interrupt in the handler for a PCI
board.  It ended up being called ~300k times per second.  The system
load was noticeable.

-- 
Måns Rullgård
mru@kth.se

