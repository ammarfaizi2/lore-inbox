Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWBTQwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWBTQwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbWBTQwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:52:05 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:57868 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1161028AbWBTQwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:52:04 -0500
Date: Mon, 20 Feb 2006 17:51:53 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler?
Message-ID: <20060220165153.GA33155@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <200602131116.41964.david-b@pacbell.net> <200602181251.09865.david-b@pacbell.net> <43F80ACC.20704@cfl.rr.com> <200602192150.05567.david-b@pacbell.net> <43F9E95A.6080103@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9E95A.6080103@cfl.rr.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 11:07:54AM -0500, Phillip Susi wrote:
> Again, the hardware is perfectly free to power off the usb bus during 
> suspend to ram.  Most systems choose not to because they allow wake from 
> usb, but not all do.

USB has this additional problem that devices lose their addresses when
the power is removed (it's very agressively hotplug).  So you can have
the devices moving around under your feet between poweroff and poweron
just because the devices happened to have enumerated in a different
order at boot time.

  OG.

