Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbUKPVYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUKPVYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbUKPVYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:24:44 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:31722 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261822AbUKPVVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:21:16 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: Linux 2.6.10-rc2 SAVAGEFB startup crash
Date: Wed, 17 Nov 2004 05:20:58 +0800
User-Agent: KMail/1.5.4
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <200411162043.23585.adaplas@hotpop.com> <20041116172748.GA2499@titan.lahn.de>
In-Reply-To: <20041116172748.GA2499@titan.lahn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411170520.59576.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 November 2004 01:27, Philipp Matthias Hahn wrote:
> Hello Antonio, LKML!
>
> On Tue, Nov 16, 2004 at 08:43:22PM +0800, Antonino A. Daplas wrote:
> > On Tuesday 16 November 2004 15:55, Philipp Matthias Hahn wrote:
> > > 2.6.10-rc2 on Debian i586 crashed during startup.
>
> ...
>
> > Try rc1-mm5, rc2-mm1 or apply this particular changeset:
> >
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1
> >/2.6.10-rc1-mm5/broken-out/fbdev-allow-mode-change-even-if-edid-block-is-n
> >ot-found.patch
>
> That fixed the crash, but the screen looks very broken on my notebook
> after boot. Switching between XFree86 and SavageFB also locked up the
> kernel hard.

Try booting at the native resolution of your notebook, for example:

video=savagefb:1024x768@60

Tony


