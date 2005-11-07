Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVKGLfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVKGLfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 06:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVKGLfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 06:35:09 -0500
Received: from attila.bofh.it ([213.92.8.2]:65489 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S932450AbVKGLfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 06:35:08 -0500
Date: Mon, 7 Nov 2005 12:33:29 +0100
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14, udev: unknown symbols for ehci_hcd
Message-ID: <20051107113329.GA7632@wonderland.linux.it>
References: <436CD1BC.8020102@t-online.de> <20051105162503.GC20686@kroah.com> <436D9BDE.3060404@t-online.de> <20051106215158.GB3603@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106215158.GB3603@kroah.com>
User-Agent: Mutt/1.5.11
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 06, Greg KH <greg@kroah.com> wrote:

> This seems to be a Debian issue for some odd reason, I suggest filing a
> bug against the udev package (or just tagging onto the existing bug for
> this problem, I've seen it in there already...)
The reason this is usually seen only on Debian systems is that I am the
first one who shipped an udev package which runs many parallel modprobe
commands, but this is a genuine kernel/modprobe bug.

-- 
ciao,
Marco
