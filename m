Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbTIITkI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264517AbTIITkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:40:08 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:48645 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264514AbTIITkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:40:04 -0400
Date: Tue, 9 Sep 2003 21:40:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.6.0-test5: configcheck results
Message-ID: <20030909194001.GB3009@mars.ravnborg.org>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>
References: <20030909100412.A25143@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909100412.A25143@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 10:04:12AM +0100, Russell King wrote:
> Hi all,
> 
> I just ran make configcheck on 2.6.0-test5 and the results are:
> 
>     832 files need linux/config.h but don't actually include it.
>     689 files which include linux/config.h but don't require the header.

Randy, you have looked into related perl scripts. Is the result of
checkconfig.pl reliable?

	Sam
