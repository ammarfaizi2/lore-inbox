Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWBTJnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWBTJnF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 04:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWBTJnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 04:43:05 -0500
Received: from canadatux.org ([81.169.162.242]:36241 "EHLO
	zoidberg.canadatux.org") by vger.kernel.org with ESMTP
	id S932407AbWBTJnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 04:43:04 -0500
Date: Mon, 20 Feb 2006 10:43:00 +0100
From: Matthias Hensler <matthias@wspse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220094300.GC19293@kobayashi-maru.wspse.de>
Reply-To: Matthias Hensler <matthias@wspse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <200602200709.17955.nigel@suspend2.net> <20060219212952.GI15311@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060219212952.GI15311@elf.ucw.cz>
Organization: WSPse (http://www.wspse.de/)
X-Gummibears: Bouncing here and there and everywhere
X-Face: &Tv]9SsNpb/$w8\G-O%>W02aApFW^P>[x+Upv9xQB!2;iD9Y1-Lz'qlc{+lL2Y>J(u76Jk,cJ@$tP2-M%y?^'jn2J]3C'ss_~"u?kA^X&{]h?O?@*VwgSGob73I9r}&S%ktup0k2!neScg3'HO}PU#Ac>jwNL|P@f|f*sz*cP'hi)/<JQC4|Q[$D@aQ"C{$>a=6.rc-P1vXarjVXlzClmNfcSy/$4tQz
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, Feb 19, 2006 at 10:29:52PM +0100, Pavel Machek wrote:
> Maybe very little of substance is being done in userspace, but all the
> uglyness can stay there. I no longer need LZF in kernel, special
> netlink API for progress bar (progress bar naturally lives in
> userland), no plugin infrastructure needed, etc.

Linux has a whole crypto API in the kernel, so why is it a problem to
have LZF there too?

About the progress bar: this is already implemented in userspace, the
kernel just forwards the progress via netlink to it. Not necessarily
ugly I think.

Regards,
Matthias
