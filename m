Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbTEPIXf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 04:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTEPIXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 04:23:35 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:4087 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S264375AbTEPIXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 04:23:35 -0400
Date: Fri, 16 May 2003 10:36:20 +0200
From: Damian =?iso-8859-2?Q?Ko=B3kowski?= <deimos@deimos.one.pl>
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: radeonfb and acpi
Message-ID: <20030516083620.GA1687@deimos.one.pl>
References: <20030515195025.GB696@gandalf.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030515195025.GB696@gandalf.home.lxtec.de>
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: 1 will be enough!
X-GG: 88988
X-ICQ: 59367544
X-JID: deimos@jabber.gda.pl
X-Operating-System: Slackware GNU/Linux, kernel 2.4.21-rc2-ac1, up  1:05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 09:50:25PM +0200, Elimar Riesebieter wrote:
> BTW: Which kernel-params do I need to start radeonfb with
> video:radeonfb=1280x1024-16@75 ? The FB even starts with 
> colour frame buffer device 80x30.

./home/deimos. # cat /etc/lilo.conf | grep radeon
append="video=radeon:1024x768-32@100 hdb=ide-scsi"
./home/deimos. #

P.S. For 2.5.x Use _radeonfb_

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
