Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266581AbUBLXpq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 18:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266587AbUBLXpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 18:45:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266581AbUBLXpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 18:45:44 -0500
Date: Thu, 12 Feb 2004 15:38:02 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Message-Id: <20040212153802.65adae84.rddunlap@osdl.org>
In-Reply-To: <200402130615.10608.mhf@linuxmail.org>
References: <200402130615.10608.mhf@linuxmail.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 06:15:10 +0800 Michael Frank <mhf@linuxmail.org> wrote:

| +Centralized exiting of functions
| +
| +Albeit deprecated by some people, the goto statement is used frequently
| +by compilers in form of the unconditional jump instruction.
| +
| +The goto statement comes handy when a function exits from multiple
                     comes in handy

| +locations and some common work such as cleanup has to be done.

| +		Chapter : Parenthesis in expressions
| +
| +Complex expressions are easier to understand and maintain when extra
| +parenthesis are used. Here is an extreme example
| +
| +x = (((a + (b * c)) & d) | e)  // would work also without any parenthesis

parentheses (plural)

| +Macros defining expressions must enclose the expression in parenthesis
parentheses

| +to reduce sideeffects.
side effects (or side-effects) (i.e., not one word)


| +		Chapter : printk formating
| +
| +Periods terminating kernel messages are deprecated
| +
| +Usage of the apostrophe <'> in kernel messages is deprecated
| +
| +Mis-spellings allowed in kernel messages are:
| +
| +	dont, cant
| +
| +Printing numbers in parenthesis ie (%d) is deprecated

I don't know that we reached any concensus on these.  I think
that these comments are just noise (IMO of course).
I guess I'll spell out "do not" and "cannot".

--
~Randy
