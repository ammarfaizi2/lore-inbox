Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbSLOLHV>; Sun, 15 Dec 2002 06:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbSLOLHU>; Sun, 15 Dec 2002 06:07:20 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:45584 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266356AbSLOLHU>;
	Sun, 15 Dec 2002 06:07:20 -0500
Date: Sun, 15 Dec 2002 12:14:55 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, kai@tp1.ruhr-uni-bochum.de
Subject: Re: [PATCH] Remove Rules.make from Makefiles (1/3)
Message-ID: <20021215111455.GB1092@mars.ravnborg.org>
Mail-Followup-To: Brian Gerst <bgerst@quark.didntduck.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	kai@tp1.ruhr-uni-bochum.de
References: <3DFB70D3.9010506@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DFB70D3.9010506@quark.didntduck.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2002 at 12:56:35PM -0500, Brian Gerst wrote:
> Makefiles no longer need to include Rules.make, which is currently an 
> empty file.  This patch removes it from the arch tree Makefiles.

I have been working together with a few of the architecture maintainers.
Could you do a new version that will left out the following architectures:
sparc and ia64.
The changes are on the way from the architecture trees anyways, and this
would just result in too many rejects.

Otherwise thanks for the nice work, I hope you had some smart way to do it.

	Sam
