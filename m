Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUFSQuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUFSQuC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUFSQtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:49:41 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:941 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S264656AbUFSQel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:34:41 -0400
Message-ID: <40D46B6C.9618B196@users.sourceforge.net>
Date: Sat, 19 Jun 2004 19:35:56 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com>
			<mailman.1087541100.18231.linux-kernel2news@redhat.com> <20040618124716.183669f8@lembas.zaitcev.lan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> Arjan van de Ven <arjanv@redhat.com> wrote:
> > On Fri, 2004-06-18 at 02:09, 4Front Technologies wrote:
> > > I am writing this message to bring a huge problem to light. SuSE has been systematically
> > > forking the linux kernel and shipping all kinds of modifications and still call their
> > > kernels 2.6.5 (for example).
> >
> > internal kernel apis change and are fair game. As a RH kernel maintainer
> > I can guarantee you that you will suffer too from internal kernel
> > changes in RH/Fedora kernels. Or from changes within the 2.6.x series.
> > Linux needs such changes to allow faster and cleaner development.
> 
> Arjan, I agree with what you're saying, but it looks to me that the 4front
> guy was complaining about the lack of meaningful EXTRAVERSION. Hard to say
> for sure when he's raving though...

Last time I checked, SUSE kernels include " characters in EXTRAVERSION and
KERNELRELEASE Makefile strings. Those " characters need to be filtered out
before EXTRAVERSION and KERNELRELEASE strings can be used.

Just another SUSE sillyness.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
