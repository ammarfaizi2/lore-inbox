Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbTL2QqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbTL2QqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:46:16 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:41442 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263606AbTL2QqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:46:12 -0500
Date: Mon, 29 Dec 2003 17:45:39 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't mount USB partition as root
Message-ID: <20031229164539.GD30794@louise.pinerecords.com>
References: <20031229173853.A32038@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031229173853.A32038@beton.cybernet.src>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-29 2003, Mon, 17:38 +0100
Karel Kulhavý <clock@twibright.com> wrote:

> Is it possible to boot kernel with root from /dev/sda1 (USB)?
> partition table: whole /dev/sda is one partition (sda1), type 83 (Linux).
> Tried also switching on and off hotplugging in kernel and it didn't help.

Well, is the device detected and the partition table scanned before the
root mount is attempted?

I believe this should work given you've compiled in all the necessary
code.  Please capture the dmesg using serial console/netconsole/whatever
and post it along with your .config.

-- 
Tomas Szepe <szepe@pinerecords.com>
