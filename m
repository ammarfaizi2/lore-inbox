Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264628AbUDVSoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264628AbUDVSoG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUDVSn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:43:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:5815 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264628AbUDVSnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:43:52 -0400
Date: Thu, 22 Apr 2004 11:37:50 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: jejb <james.bottomley@steeleye.com>
Cc: kieran@ihateaol.co.uk, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Why is CONFIG_SCSI_QLA2X_X always enabled?
Message-Id: <20040422113750.3ad2a065.rddunlap@osdl.org>
In-Reply-To: <20040422111552.5e14de00.rddunlap@osdl.org>
References: <4087E95F.5050409@ihateaol.co.uk>
	<20040422092853.55d0b011.rddunlap@osdl.org>
	<1082651974.1778.52.camel@mulgrave>
	<20040422101206.70133b42.rddunlap@osdl.org>
	<1082654926.1778.84.camel@mulgrave>
	<20040422111552.5e14de00.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004 11:15:52 -0700 Randy.Dunlap wrote:

| On 22 Apr 2004 13:28:46 -0400 James Bottomley wrote:
| 
| | On Thu, 2004-04-22 at 13:12, Randy.Dunlap wrote:
| | > As it is, for some large %age of users (say 99% ?), those 6 qla drivers
| | > show up in the config menu when they aren't needed or wanted.
| | > They get in the way.
| | 
| | So you want a "Do you want Qlogic drivers" question followed by the 6
| | drivers if Y?
| | 
| | I'm less enthused about that.  I know there's precedent for it in the
| | net drivers, but I've always thought it caused more confusion than it
| | removed.  Traditionally, in SCSI, we've always presented every possible
| | driver in our list.

BTW, thanks for clarifying that.  Now we (or I) know.

| | I thought the initial complaint you were trying to fix was the "why does
| | this show up in my .config one"?
| 
| The initial complaint was in $SUBJECT:
| .config file always contains CONFIG_SCSI_QLA2XXX=y

which isn't a problem by itself, as you suggest (maybe?).

| and that's not needed, but the Kconfig file as is causes that.
| Then that causes the further noise.

--
~Randy
