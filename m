Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbTEHI5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 04:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbTEHI5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 04:57:42 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:43161 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261232AbTEHI5l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 04:57:41 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 8 May 2003 11:06:38 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: ark925@netscape.net
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: your mail
Message-ID: <20030508090638.GE17300@bytesex.org>
References: <053C05D4.4D025D2E.0005F166@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053C05D4.4D025D2E.0005F166@netscape.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually it does in some cases. I know of two devices that have analog
> tuners on an smbus-like interface (OV511 USB TV and W9967CF USB TV). The
> tuner can be controlled using a pair of i2c_smbus_write_byte_data()
> calls.

Hmm, maybe we should rename the SMBUS class to SENSORS or MAINBOARD or
something like that?  I assumed you smbus interfaces are used for
mainboard sensors only ...

> Would a patch that adds smbus algorithm support to tuner.c be
> acceptable?

Yes.  Certainly makes more sense than duplicating the whole rest of
tuner.c just for a smbus-aware tuner driver ;)

  Gerd

-- 
sigfault
