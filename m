Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263144AbTCWS5l>; Sun, 23 Mar 2003 13:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbTCWS5k>; Sun, 23 Mar 2003 13:57:40 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:10764 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263144AbTCWS5k>;
	Sun, 23 Mar 2003 13:57:40 -0500
Date: Sun, 23 Mar 2003 20:08:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add checkstack Makefile target
Message-ID: <20030323190844.GA6699@mars.ravnborg.org>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20030303211647.GA25205@wohnheim.fh-wedel.de> <20030304070304.GP4579@actcom.co.il> <20030304072443.GA5503@wohnheim.fh-wedel.de> <20030304102121.GC6583@wohnheim.fh-wedel.de> <20030304105739.GD6583@wohnheim.fh-wedel.de> <20030304190854.GA1917@mars.ravnborg.org> <20030305145149.GA7509@wohnheim.fh-wedel.de> <20030305191516.GB1841@mars.ravnborg.org> <20030305195451.GB10871@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030305195451.GB10871@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 08:54:51PM +0100, Jörn Engel wrote:
> 
> I wonder if checkstack should be added to noconfig_targets. In fact, I
> wonder if I put checkstack in the right spot at all. Sam?

checkstack needs a configured and build kernel, hence the
prerequisite vmlinux.
So it is located at the right spot and shall not be listed in
noconfig_targets.

Only tiny issue is that you miss:
.PHONY: checkstack

	Sam
