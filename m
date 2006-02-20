Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWBTJre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWBTJre (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 04:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWBTJre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 04:47:34 -0500
Received: from canadatux.org ([81.169.162.242]:44972 "EHLO
	zoidberg.canadatux.org") by vger.kernel.org with ESMTP
	id S932435AbWBTJrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 04:47:33 -0500
Date: Mon, 20 Feb 2006 10:47:28 +0100
From: Matthias Hensler <matthias@wspse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220094728.GD19293@kobayashi-maru.wspse.de>
Reply-To: Matthias Hensler <matthias@wspse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602200709.17955.nigel@suspend2.net> <20060219212952.GI15311@elf.ucw.cz> <200602201025.01823.nigel@suspend2.net> <20060220005333.GL15608@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060220005333.GL15608@elf.ucw.cz>
Organization: WSPse (http://www.wspse.de/)
X-Gummibears: Bouncing here and there and everywhere
X-Face: &Tv]9SsNpb/$w8\G-O%>W02aApFW^P>[x+Upv9xQB!2;iD9Y1-Lz'qlc{+lL2Y>J(u76Jk,cJ@$tP2-M%y?^'jn2J]3C'ss_~"u?kA^X&{]h?O?@*VwgSGob73I9r}&S%ktup0k2!neScg3'HO}PU#Ac>jwNL|P@f|f*sz*cP'hi)/<JQC4|Q[$D@aQ"C{$>a=6.rc-P1vXarjVXlzClmNfcSy/$4tQz
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, Feb 20, 2006 at 01:53:33AM +0100, Pavel Machek wrote:
> Only feature I can't do is "save whole pagecache"... and 14000 lines
> of code for _that_ is a bit too much. I could probably patch my kernel
> to dump pagecache to userspace, but I do not think it is worth the
> effort.

I do not think that Suspend 2 needs 14000 lines for that, the core is
much smaller. But besides, _not_ saving the pagecache is a really _bad_
idea. I expect to have my system back after resume, in the same state I
had left it prior to suspend. I really do not like it how it is done by
Windows, it is just ugly to have a slowly responding system after
resume, because all caches and buffers are gone.

I can only speak for myself, but I want to work with my system from the
moment my desktop is back.

Regards,
Matthias
