Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVJFIWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVJFIWO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 04:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVJFIWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 04:22:14 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:60559 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750736AbVJFIWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 04:22:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Date: Thu, 6 Oct 2005 10:23:15 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@cyclades.com>
References: <20051002231332.GA2769@elf.ucw.cz> <200510051020.15400.rjw@sisk.pl> <20051005083341.GA22034@elf.ucw.cz>
In-Reply-To: <20051005083341.GA22034@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510061023.16016.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 5 of October 2005 10:33, Pavel Machek wrote:
> Hi!
> 
> > OK, but if we decide to move some functions from one file to another,
> > we'll have to wait for another "settle down" period, I think.
> 
> Yes...

Then I'd propose that we wait for the next "settle down" period with the
split and apply all of the bugfixes and cleanups now.

I don't think we'll gain anything by splitting the files immediately and
there are some cleanups not in-line with the split (eg. the Nigel's patch
eliminating the references to PG_reserved).

Greetings,
Rafael
