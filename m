Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbUKPR2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUKPR2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUKPR2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:28:12 -0500
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:50916
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S262063AbUKPR2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:28:09 -0500
Date: Tue, 16 Nov 2004 18:27:48 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: adaplas@pol.net
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2 SAVAGEFB startup crash
Message-ID: <20041116172748.GA2499@titan.lahn.de>
Mail-Followup-To: adaplas@pol.net,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <20041116075548.GB4014@titan.lahn.de> <200411162043.23585.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411162043.23585.adaplas@hotpop.com>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Antonio, LKML!

On Tue, Nov 16, 2004 at 08:43:22PM +0800, Antonino A. Daplas wrote:
> On Tuesday 16 November 2004 15:55, Philipp Matthias Hahn wrote:
> > 2.6.10-rc2 on Debian i586 crashed during startup.
...
> Try rc1-mm5, rc2-mm1 or apply this particular changeset:
>
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/fbdev-allow-mode-change-even-if-edid-block-is-not-found.patch

That fixed the crash, but the screen looks very broken on my notebook
after boot. Switching between XFree86 and SavageFB also locked up the
kernel hard.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
