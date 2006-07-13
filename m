Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWGMS3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWGMS3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWGMS3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:29:21 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:27557 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1030274AbWGMS3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:29:21 -0400
Date: Thu, 13 Jul 2006 12:29:19 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, wookey@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support DOS line endings
Message-ID: <20060713182919.GJ1629@parisc-linux.org>
References: <20060707173458.GB1605@parisc-linux.org> <Pine.LNX.4.64.0607080513280.17704@scrub.home> <20060713181825.GA22895@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713181825.GA22895@mars.ravnborg.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 08:18:25PM +0200, Sam Ravnborg wrote:
> Negative index'es always make me supsicious.
> I've applied followign patch.
> The fgets thing I have not looked at.

Did you apply the "case '\r'" hunk (around line 269) too?  If not,
it'll spew "unexpected data" error messages for every blank line.
