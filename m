Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTJOUaa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 16:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTJOUaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 16:30:30 -0400
Received: from main.gmane.org ([80.91.224.249]:30088 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264304AbTJOUa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 16:30:27 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: orinoco wireless pcmcia driver in test5
Date: Wed, 15 Oct 2003 22:30:23 +0200
Message-ID: <yw1xllrmfdls.fsf@users.sourceforge.net>
References: <20031015213013.5244bb4c.atte@ballbreaker.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:nWp1ceuhHt1z/PQ1pHBa6AgthWI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atte André Jensen <atte@ballbreaker.dk> writes:

> What is the result (and purpose) of no mention of the orinoco wireless
> drivers in the .config for test5?
>
> [atte@aarhus atte]$ grep -i orinoco /usr/src/linux-2.6.0-test5/.config
> [atte@aarhus atte]$ 
>
> Will the driver be linked in anyhow? If not is there a fix?

In -test7, it's called CONFIG_HERMES.  I've got these lines in my
.config:

CONFIG_HERMES=m
CONFIG_PCMCIA_HERMES=m
CONFIG_NET_WIRELESS=y

I'm sending this mail over a wireless card using the orinoco module,
so it works.

-- 
Måns Rullgård
mru@users.sf.net

