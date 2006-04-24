Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWDXIhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWDXIhW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWDXIhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:37:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30677 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932068AbWDXIhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:37:20 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Arjan van de Ven <arjan@infradead.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060424082831.GI440@marowsky-bree.de>
References: <20060417173319.GA11506@infradead.org>
	 <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417195146.GA8875@kroah.com>
	 <1145309184.14497.1.camel@localhost.localdomain>
	 <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>
	 <4445484F.1050006@novell.com> <20060420211308.GB2360@ucw.cz>
	 <444AF977.5050201@novell.com>
	 <200604230933.k3N9XTZ8019756@turing-police.cc.vt.edu>
	 <20060423145846.GA7495@thorium.jmh.mhn.de>
	 <20060424082831.GI440@marowsky-bree.de>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 10:37:17 +0200
Message-Id: <1145867837.3116.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 10:28 +0200, Lars Marowsky-Bree wrote:
> On 2006-04-23T16:58:47, Thomas Bleher <bleher@informatik.uni-muenchen.de> wrote:
> 
> > Later, the admin decides to save space, deletes the bin/ directory and
> > instead links /bin/ls into the chroot. Suddenly the system is easily
> > exploitable.
> 
> Security models can be compromised by root or by dumb accomplices. Film
> at eleven.

well this security model wants to partition root, more or less. So to
some degree looking at it makes sense; just not so much in the given
example ;)


> Seriously, this is not helpful. Could we instead focus on the
> technical argument wrt the kernel patches?

I disagree with your stance here; trying to poke holes in the mechanism
IS useful and important. In addition to looking at the kernel patches. 
I understand your employer wants this merged asap, but that's no reason
to try to stop discussions that try to poke holes in the security model.


