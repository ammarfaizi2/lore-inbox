Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275103AbTHLIjc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 04:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275108AbTHLIjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 04:39:32 -0400
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:3847
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S275103AbTHLIjb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 04:39:31 -0400
Date: Tue, 12 Aug 2003 10:39:00 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: "Mark W. Alexander" <slash@dotnetslash.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test3 problems on Acer TravelMate 260 (ALSA,ACPIvsSynaptics,yenta)
Message-ID: <20030812083900.GA2974@man.beta.es>
References: <20030811173538.GA2604@man.beta.es> <Pine.LNX.4.44.0308112137340.20222-100000@llave.eproinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308112137340.20222-100000@llave.eproinet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> existance on 2.6. Could you post or send me your PCIC=yenta config file?
> (Debian /etc/default/pcmcia. I don't know where on other distros.)

I'm running Debian unstable here but I do not have anything special on that
file, just the defaults changing the driver into yenta_socket, and even this
is not necesary if you happen to have just yenta compiled.

# Defaults for pcmcia (sourced by /etc/init.d/pcmcia)
PCMCIA=yes
PCIC=yenta_socket
PCIC_OPTS=
CORE_OPTS=
CARDMGR_OPTS=

Regards...
-- 
Manty/BestiaTester -> http://manty.net
