Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbTEMSTQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbTEMSTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:19:16 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7047 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262289AbTEMSTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:19:10 -0400
Date: Tue, 13 May 2003 11:27:53 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: linux-kernel@vger.kernel.org, ricklind@us.ibm.com
Subject: Re: Missing disc io stats in /proc/stat in 2.5.69?
Message-Id: <20030513112753.7612dabd.rddunlap@osdl.org>
In-Reply-To: <3EC0A303.5050902@tequila.co.jp>
References: <3EC0A303.5050902@tequila.co.jp>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003 16:47:15 +0900 Clemens Schwaighofer <cs@tequila.co.jp> wrote:

| just a more general question. Did the Disc IO stats disappear from
| /proc/stat in 2.5.69? Or do I have to activated them somehow?

They should show up under /sys/block/<dev> (after mounting
sysfs on /sys).

Rick, were you working on some docs for this?
or are some already available?

--
~Randy
