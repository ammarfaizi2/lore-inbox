Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVEKOim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVEKOim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 10:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVEKOeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 10:34:25 -0400
Received: from holomorphy.com ([66.93.40.71]:24259 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261968AbVEKOdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 10:33:51 -0400
Date: Wed, 11 May 2005 07:30:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jan Dittmer <jdittmer@ppp0.net>, spyro@f2s.com, zippel@linux-m68k.org,
       starvik@axis.com, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net, dev-etrax@axis.com,
       sparclinux@vger.kernel.org
Subject: Re: select of non-existing I2C* symbols
Message-ID: <20050511143010.GF9304@holomorphy.com>
References: <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <20050506235842.A23651@flint.arm.linux.org.uk> <427C9DBD.1030905@ppp0.net> <20050507122622.C11839@flint.arm.linux.org.uk> <427CC082.4000603@ppp0.net> <20050507144135.GL3590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050507144135.GL3590@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 03:20:02PM +0200, Jan Dittmer wrote:
>>...
>> Link to this page: http://l4x.org/k/?diff[v1]=mm

On Sat, May 07, 2005 at 04:41:35PM +0200, Adrian Bunk wrote:
> arm26, cris, sparc: select of non-existing I2C* symbols:
> @ Ian, Mikael, William:
> This could be fixed by sourcing drivers/i2c/Kconfig in arch/*/Kconfig,
> but it would be better to switch to use drivers/Kconfig.
> @ Roman:
> Shouldn't kconfig exit with an error if a not available symbol gets
> selected?

You're telling me I have to futz with the i2c Kconfig just to cope with
it not existing?


-- wli
