Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbTDPNOb (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 09:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbTDPNOb 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 09:14:31 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:40708 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264362AbTDPNO1 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 09:14:27 -0400
Date: Wed, 16 Apr 2003 15:23:24 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Adrian Etchevarne <aetcheva@it.itba.edu.ar>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Private namespaces
Message-ID: <20030416132324.GA18700@win.tue.nl>
References: <1052141040.355.12.camel@labunix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052141040.355.12.camel@labunix>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 10:23:56AM -0300, Adrian Etchevarne wrote:

> 	I've been looking for instructions to use private namespaces in Linux,
> without results. Can anyone tell where is the documentation about it?
> (I'm not refering to chroot(), but to /proc/<pid>/mounts). Or the proper
> files in the kernel sources?

A tiny demo program is given in
  http://www.win.tue.nl/~aeb/linux/lk/lk-6.html#ss6.3.3

In the kernel source, grep for CLONE_NEWNS.

