Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUCPSsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUCPSsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:48:22 -0500
Received: from nodns-212-69-243-51.first4it.co.uk ([212.69.243.51]:45071 "HELO
	linuxoutlaws.co.uk") by vger.kernel.org with SMTP id S261183AbUCPSsQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:48:16 -0500
Date: Tue, 16 Mar 2004 18:45:47 +0000
From: Rob Shakir <rob@rshk.co.uk>
To: Emmanuel Fleury <fleury@cs.auc.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with atkbd.c
Message-ID: <20040316184547.GA21736@rshk.co.uk>
References: <1079461752.24676.23.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079461752.24676.23.camel@rade7.s.cs.auc.dk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 07:29:12PM +0100, Emmanuel Fleury wrote:
> Hi,
> 
> I noticed today that I got several time the following error log in my
> /var/log/messages:
> 
> Mar 16 14:00:59 hermes vmunix: atkbd.c: Unknown key released (translated
> set 2,
> code 0x7a on isa0060/serio0).
> Mar 16 14:00:59 hermes vmunix: atkbd.c: This is an XFree86 bug. It
> shouldn't access hardware directly.
> Mar 16 14:00:59 hermes vmunix: atkbd.c: Unknown key released (translated
> set 2,
> code 0x7a on isa0060/serio0).
> Mar 16 14:00:59 hermes vmunix: atkbd.c: This is an XFree86 bug. It
> shouldn't access hardware directly.
> 
> Is it a known bug ?

Yes, it's in the 2.6 input drivers FAQ by Vojtech Pavlik, you can read the FAQ at: http://lwn.net/Articles/69107/.

Rob Shakir
