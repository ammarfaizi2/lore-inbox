Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264046AbTEOOjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbTEOOjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:39:04 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4291 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264046AbTEOOjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:39:03 -0400
Date: Thu, 15 May 2003 07:47:39 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, VANDROVE@vc.cvut.cz
Subject: Re: [PATCH][2.5] VMWare doesn't like sysenter
Message-Id: <20030515074739.223a6c28.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.50.0305150400550.19782-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0305150400550.19782-100000@montezuma.mastecende.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003 04:02:31 -0400 (EDT) Zwane Mwaikambo <zwane@linuxpower.ca> wrote:

| I get a monitor error in VMWare4 with a sysenter syscall enabled kernel, 
| this patch simply disables sysenter based syscalls but doesn't clear the 
| SEP bit in the capabilities.

| +static int __init do_nosysenter(char *s)
| +{
| +	nosysenter = 1;
| +	return 1;
| +}
| +__setup("nosysenter", do_nosysenter);

Needs entry in Documentation/kernel-parameters.txt also
if/when accepted.

--
~Randy
