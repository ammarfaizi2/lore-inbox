Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161108AbWJDHT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbWJDHT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbWJDHT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:19:58 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:20429 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1161108AbWJDHT6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:19:58 -0400
Subject: Re: debugfs oddity
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg KH <gregkh@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Joel Becker <Joel.Becker@oracle.com>, Michael Buesch <mb@bu3sch.de>
In-Reply-To: <20061003052839.GA18989@suse.de>
References: <1159781104.2655.47.camel@ux156>
	 <20061003052839.GA18989@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 09:20:46 +0200
Message-Id: <1159946446.2817.2.camel@ux156>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
X-sips-origin: local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 22:28 -0700, Greg KH wrote:

> sysfs works much differently here, as does configfs.  debugfs just uses
> the vfs layer's ramfs stack, so any potential problem here is probably
> also present in ramfs.  Have you tried that out?

Just had a go -- ramfs works as expected, at least when I do the dance
from userspace as I had in (a')-(d').

johannes
