Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbTL2Rgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTL2Rgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:36:31 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:52194 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263539AbTL2Rep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:34:45 -0500
Date: Mon, 29 Dec 2003 18:34:12 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't mount USB partition as root
Message-ID: <20031229173412.GH30794@louise.pinerecords.com>
References: <20031229173853.A32038@beton.cybernet.src> <20031229164539.GD30794@louise.pinerecords.com> <20031229183118.A32137@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031229183118.A32137@beton.cybernet.src>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-29 2003, Mon, 18:31 +0100
Karel Kulhavý <clock@twibright.com> wrote:

> > > Is it possible to boot kernel with root from /dev/sda1 (USB)?
> > > partition table: whole /dev/sda is one partition (sda1), type 83 (Linux).
> > > Tried also switching on and off hotplugging in kernel and it didn't help.
> > 
> > Well, is the device detected and the partition table scanned before the
> > root mount is attempted?
> 
> The messages jump around fast and there is no possibility to scroll
> back once the kernel stops, but I am convinced that nothing is said about
> detecting the device.
> 
> However, if booting the kernel "normally", the device gets detected (later).

Sounds like an initrd to me.  Are you using one?

> How do I use the console? Is it something like nullmodem cable console in
> Windows NT?  I have given away my nullmodem cable to a friend for purpose of
> debugging NT kernel so what possibilities remain?

Google around for "netconsole" or use 2.6.0-mm2, which has it included.

-- 
Tomas Szepe <szepe@pinerecords.com>
