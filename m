Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263961AbTDNVqE (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263950AbTDNVpd (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:45:33 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:65289
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263961AbTDNVpN 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:45:13 -0400
Subject: Re: 2.5 'what to expect' document.
From: Robert Love <rml@tech9.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030414214807.GB993@mars.ravnborg.org>
References: <20030414193138.GA24870@suse.de>
	 <20030414214807.GB993@mars.ravnborg.org>
Content-Type: text/plain
Organization: 
Message-Id: <1050357422.3664.85.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 14 Apr 2003 17:57:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 17:48, Sam Ravnborg wrote:

> > - The bdflush() syscall is now officially deprecated. The syscall
> >   does nothing, and prints a stern warning to users. The functionality
> >   is replaced by the pdflush deamons.
>
> Can I safely delete /sbin/update from my initscripts then?

If you never plan to boot 2.2 or earlier, yes.

	Robert Love



