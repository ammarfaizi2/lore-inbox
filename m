Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266594AbUBQVHC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266584AbUBQVHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:07:00 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:62362 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266594AbUBQVGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:06:07 -0500
Date: Tue, 17 Feb 2004 22:06:04 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, matthias.andree@gmx.de,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com.br
Subject: Re: [Lksctp-developers] Re: [PATCH] net/sctp/Config.in make oldconfig compatibility (bash)
Message-ID: <20040217210603.GA5398@merlin.emma.line.org>
Mail-Followup-To: Sridhar Samudrala <sri@us.ibm.com>,
	"David S. Miller" <davem@redhat.com>,
	lksctp-developers@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com.br
References: <20040217122347.GA15213@merlin.emma.line.org> <Pine.LNX.4.58.0402171035440.32361@localhost.localdomain> <20040217110541.6d71ef18.davem@redhat.com> <Pine.LNX.4.58.0402171115030.5136@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171115030.5136@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Sridhar Samudrala wrote:

> The other space introduced in Matthias patch is in the following lines.
> -        choice 'SCTP: Cookie HMAC Algorithm' \
> +        choice '    SCTP: Cookie HMAC Algorithm' \
> 
> I am not sure if this is needed.

This is not technically needed, but visual fluff, added in order to make
these SCTP algorithm choices align with the previous SCTP options - it's
all about indentation.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
