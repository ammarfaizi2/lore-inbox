Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVBORtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVBORtG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVBORtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:49:05 -0500
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:50122
	"HELO fargo") by vger.kernel.org with SMTP id S261628AbVBORro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:47:44 -0500
Date: Tue, 15 Feb 2005 18:48:24 +0100
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, sergio@sergiomb.no-ip.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give	dev=/dev/hdX as device
Message-ID: <20050215174824.GA32536@fargo>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Randy.Dunlap" <rddunlap@osdl.org>, sergio@sergiomb.no-ip.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1108426832.5015.4.camel@bastov> <1108434128.5491.8.camel@bastov> <42115DA2.6070500@osdl.org> <1108486952.4618.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1108486952.4618.10.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Feb 15 at 05:02:35, Alan Cox wrote:
> > burning CDs.  Just use the ide-cd driver (module) and
> > specify the CD burner device as /dev/hdX.
> 
> This information is unfortunately *WRONG*. The base 2.6 ide-cd driver is
> vastly inferior to ide-scsi. The ide-scsi layer knows about proper error
> reporting, end of media and other things that ide-cd does not.
> 
> The -ac ide-cd knows some of the stuff that ide-cd needs to and works
> with various drive/disk combinations the base code doesn't but ide-scsi
> still handles CD's better.

Is going to be merged soon to the mainline 2.6 kernel? I guess this
bad error handling from ide-cd has something to do with recent messages
about kernel hanging with bad dvd media.

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
