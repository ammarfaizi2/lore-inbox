Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTDDUZX (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 15:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTDDUZX (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 15:25:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7187 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261304AbTDDUZW (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 15:25:22 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: VGER's filters..
Date: 4 Apr 2003 12:36:20 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6kqc4$2td$1@cesium.transmeta.com>
References: <20030404181054.GT29167@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030404181054.GT29167@mea-ext.zmailer.org>
By author:    Matti Aarnio <matti.aarnio@zmailer.org>
In newsgroup: linux.dev.kernel
> 
> With Yahoo I had at first immense problems to get any email from them,
> as their SMTP email sender uses INVALID protocol:
> 
> <<-  MAIL FROM: <yahoo-dev-null@yahoo-inc.com>
> ->>  501 5.1.7 strangeness between ':' and '<': <yahoo-dev-null@yahoo-inc.com>
> When you read really carefully RFC 821 / 2821 syntax about that,
> you will see that it does not allow space in that place.
> Sendmail does, and that has forced others to extend the syntax alike.
> 

Sendmail, and a whole bunch of other mailers, have taken the more
liberal approach of allowing any RFC 822-compliant address in this
place (which is a *lot* more liberal than an RFC 821-compliant
reverse-path.)  This is consistent with the "be liberal in what you
accept, conservative in what you send" philosophy of network
interoperability.

I suspect in Sendmail it naturally falls out of using a single set of
canonicalization rules for all syntax.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
