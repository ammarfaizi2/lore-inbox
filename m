Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUAVPv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 10:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbUAVPv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 10:51:27 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:11424 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264505AbUAVPv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 10:51:26 -0500
Date: Thu, 22 Jan 2004 15:50:16 +0000
From: Dave Jones <davej@redhat.com>
To: Julien Oster <lkml-3141@mc.frodoid.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: parhelia doesn't work anymore with 2.6.1
Message-ID: <20040122155016.GA18361@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Julien Oster <lkml-3141@mc.frodoid.org>,
	linux-kernel@vger.kernel.org
References: <20040122152137.GA1138@frodo.midearth.frodoid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122152137.GA1138@frodo.midearth.frodoid.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 04:21:37PM +0100, Julien Oster wrote:

 > I know the Matrox Parhelia kernel driver ist partly a binary only
 > driver, but I am not explicitly asking for support on that driver.

actually, you are. agpgart works fine with free drivers.

 > My question is: what has changed in AGP code or similar between 2.4.24
 > and 2.6.1 that can make my Parhelia unusable?

'lots'. seriously, they're worlds apart. they're not the same driver any more.
in fact in 2.6, agpgart is multiple drivers.

Trying to use a 2.4 module on 2.6 is going to cause you pain. lots of pain.

		Dave

