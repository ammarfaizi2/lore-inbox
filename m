Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUHSG5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUHSG5A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 02:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUHSG5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 02:57:00 -0400
Received: from port-213-148-152-119.static.qsc.de ([213.148.152.119]:12971
	"EHLO mbs-software.de") by vger.kernel.org with ESMTP
	id S261405AbUHSG4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 02:56:49 -0400
Date: Thu, 19 Aug 2004 08:56:47 +0200
From: Alex Riesen <ari@mbs-software.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Packet writing problems
Message-ID: <20040819065647.GH29792@linux-ari.internal>
Reply-To: Alex Riesen <ari@mbs-software.de>
References: <20040818125719.GA6021@linux-ari.internal> <87u0v08jcw.fsf@killer.ninja.frodoid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u0v08jcw.fsf@killer.ninja.frodoid.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Oster, Wed, Aug 18, 2004 19:08:15 +0200:
> (I guess your mail was also meant to lkml?)

yes, I'm just reading the list off the archive at marc, so replies do
not go automatically to lkml if you have to copy-paste the text.

> We're making a lot of mess about some simple output.

Well, it's a lot of simple output.

>  static int pkt_good_disc(struct pktcdvd_device *pd, disc_information *di)
>  {
> +        char *mediatypename;

it is "const char*", actually. And the indentation before the line is
8 spaces, instead of 1 tab (unlike everything in the file).

