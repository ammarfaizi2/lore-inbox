Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTIKVXp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbTIKVXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:23:45 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:10770
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261538AbTIKVXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:23:44 -0400
Date: Thu, 11 Sep 2003 14:23:41 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Breno <brenosp@brasilsec.com.br>, Valdis.Kletnieks@vt.edu,
       Stan Bubrouski <stan@ccs.neu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Size of Tasks during ddos
Message-ID: <20030911212341.GB26618@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Breno <brenosp@brasilsec.com.br>, Valdis.Kletnieks@vt.edu,
	Stan Bubrouski <stan@ccs.neu.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <001b01c39047$d65cf580$f8e4a7c8@bsb.virtua.com.br> <20030911002755.GA13177@triplehelix.org> <3F5FD993.2060900@ccs.neu.edu> <009201c37860$f0d3c5f0$131215ac@poslab219> <200309111419.h8BEJbSo010948@turing-police.cc.vt.edu> <009f01c3788a$08b7f780$9f0210ac@forumci.com.br> <1063305670.3605.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063305670.3605.0.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 07:41:10PM +0100, Alan Cox wrote:
> On Iau, 2003-09-11 at 18:27, Breno wrote:
> > This is a Syn Flood DDoS 
> 
> echo "1" >/proc/sys/net/ipv4/tcp_syncookies
> 
> End of problem.

And why isn't this on by default when it's compiled in?
