Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbTLEQRv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 11:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTLEQRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 11:17:51 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:51072
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264268AbTLEQRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 11:17:49 -0500
Date: Fri, 5 Dec 2003 11:16:48 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Paul Rolland <rol@witbe.net>
cc: linux-smp@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: WARNING: MP table in the EBDA can be UNSAFE
In-Reply-To: <200312051610.hB5GALD04677@tag.witbe.net>
Message-ID: <Pine.LNX.4.58.0312051113260.10913@montezuma.fsmlabs.com>
References: <200312051610.hB5GALD04677@tag.witbe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Dec 2003, Paul Rolland wrote:

> > Did you compile your kernel with the following option?
> > IBM x440 Summit/EXA support
> >
> > CONFIG_X86_SUMMIT
> >
> I can't find this option ? Is this part of the 2.4.x branch ?

Indeed it is, you need to turn on "Multi-node NUMA system support"

CONFIG_X86_NUMA


