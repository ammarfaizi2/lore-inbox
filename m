Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVBOWIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVBOWIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVBOWHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:07:43 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:13187 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261913AbVBOWHd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:07:33 -0500
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and
	give	dev=/dev/hdX as device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David =?ISO-8859-1?Q?G=F3mez?= <david@pleyades.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, sergio@sergiomb.no-ip.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050215174824.GA32536@fargo>
References: <1108426832.5015.4.camel@bastov>
	 <1108434128.5491.8.camel@bastov> <42115DA2.6070500@osdl.org>
	 <1108486952.4618.10.camel@localhost.localdomain>
	 <20050215174824.GA32536@fargo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1108505147.4620.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Feb 2005 22:05:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-02-15 at 17:48, David Gómez wrote:
> Is going to be merged soon to the mainline 2.6 kernel? I guess this
> bad error handling from ide-cd has something to do with recent messages
> about kernel hanging with bad dvd media.

Up to the maintainer. I've been very busy on thesis stuff but I'll try
and split it out for 2.6.12pre if Bartlomiej wants the changes.

As to the DVD media hang - I think that is unrelated. The ide-cd fixes
deal with end of media error handling primarily and better reporting of
sense data. That affects multisession discs, readahead and some other
oddments rather than any hang cases


Alan

