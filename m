Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbUKPMxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUKPMxl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 07:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbUKPMxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 07:53:41 -0500
Received: from smtp-out.hotpop.com ([38.113.3.51]:40669 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261965AbUKPMxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 07:53:39 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2 SAVAGEFB startup crash
Date: Tue, 16 Nov 2004 20:43:22 +0800
User-Agent: KMail/1.5.4
Cc: Antonino Daplas <adaplas@pol.net>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <20041116075548.GB4014@titan.lahn.de>
In-Reply-To: <20041116075548.GB4014@titan.lahn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411162043.23585.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 November 2004 15:55, Philipp Matthias Hahn wrote:
> Hello LKML!
>
> 2.6.10-rc2 on Debian i586 crashed during startup.
>
> On Sun, Nov 14, 2004 at 06:49:04PM -0800, Linus Torvalds wrote:
> > Summary of changes from v2.6.10-rc1 to v2.6.10-rc2
> > ============================================
> > Antonino Daplas:

Try rc1-mm5, rc2-mm1 or apply this particular changeset:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/fbdev-allow-mode-change-even-if-edid-block-is-not-found.patch

Tony


