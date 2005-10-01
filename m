Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbVJAVjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbVJAVjW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 17:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbVJAVjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 17:39:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11916 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750865AbVJAVjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 17:39:22 -0400
Subject: Re: A possible idea for Linux: Save running programs to disk
From: Arjan van de Ven <arjan@infradead.org>
To: lokum spand <lokumsspand@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl>
References: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl>
Content-Type: text/plain
Date: Sat, 01 Oct 2005 23:39:14 +0200
Message-Id: <1128202754.8153.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-01 at 13:30 -0800, lokum spand wrote:
> I allow myself to suggest the following, although not sure if I post in
> the right group:
> 
> Suppose Linux could save the total state of a program to disk, for
> instance, imagine a program like mozilla with many open windows. I give
> it a SIGNAL-SAVETODISK and the process memory image is dropped to a
> file. I can then turn off the computer and later continue using the
> program where I left it, by loading it back into memory.
> 
> Would that be possible? At least a program can be given a ctrl-z and is

there is a LOT of state though.. the moment you add networking in the
picture the amount of state just isn't funny anymore. Your X example is
a good one as well...

