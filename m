Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbUKVS4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbUKVS4A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbUKVSyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:54:05 -0500
Received: from main.gmane.org ([80.91.229.2]:7863 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262158AbUKVSwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:52:43 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Kernel thoughts of a Linux user
Date: Mon, 22 Nov 2004 19:52:33 +0100
Message-ID: <yw1xhdnhyavi.fsf@ford.inprovide.com>
References: <200411201131.12987.gjwucherpfennig@gmx.net> <20041121182952.GA26874@kroah.com>
 <200411222233.45709.gjwucherpfennig@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:mZHFo19Y8gAynDgAnXAS+viztJM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net> writes:

> I'm a stupid idiot, but I'm sure that the sysfs and hal thing still has to
> mature for a few years. Just imagine such things like listing all
> available modem devices. Listing /sys/class/tty/*/dev without
> the virtual consoles just isn't enough.

How would you know what's connected to a serial port?  There's
absolutely no way to tell whether it's a modem or something else, at
least no way that should be attempted inside the kernel.  Manually
checking if there's a modem can be as simple as sending some harmless
AT commands, and check for reasonable replies.  The problem is that
nobody knows what these commands might do to some other device.

-- 
Måns Rullgård
mru@inprovide.com

