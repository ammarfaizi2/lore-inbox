Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTLCXJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTLCXIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:08:55 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:53439 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262115AbTLCXIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:08:37 -0500
Date: Wed, 3 Dec 2003 15:08:32 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>, David Hinds <dhinds@sonic.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Worst recursion in the kernel
Message-ID: <20031203230832.GD29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: J?rn Engel <joern@wohnheim.fh-wedel.de>,
	David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
References: <20031203143122.GA6470@wohnheim.fh-wedel.de> <20031203100709.B6625@sonic.net> <20031203190440.GA15857@wohnheim.fh-wedel.de> <20031203225743.A25889@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031203225743.A25889@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 10:57:43PM +0000, Russell King wrote:
> Yes, but the condition of the /data/ is such that it will not recurse.
> 
> A pure "can this function call that function" analysis ignoring the
> state of the data will say this will infinitely recuse.  Include
> the data, and you'll find it has a very definite recursion limit.

Is the data verified?
