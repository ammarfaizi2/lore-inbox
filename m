Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUGNXJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUGNXJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 19:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUGNXJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 19:09:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:25045 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264991AbUGNXJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 19:09:07 -0400
Date: Wed, 14 Jul 2004 15:52:28 -0700
From: Greg KH <greg@kroah.com>
To: Vernon Mauery <vernux@us.ibm.com>
Cc: pcihpd <pcihpd-discuss@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <gregkh@us.ibm.com>,
       Pat Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Jess Botts <botts@us.ibm.com>
Subject: Re: [PATCH] [2/2] acpiphp extension for 2.6.7 (final)
Message-ID: <20040714225228.GB3398@kroah.com>
References: <1087934028.2068.57.camel@bluerat> <200407071147.57604@bilbo.math.uni-mannheim.de> <1089216410.24908.5.camel@bluerat> <200407081209.42927@bilbo.math.uni-mannheim.de> <1089328415.2089.194.camel@bluerat> <20040708232827.GA20755@kroah.com> <1089331963.2089.255.camel@bluerat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089331963.2089.255.camel@bluerat>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 05:12:43PM -0700, Vernon Mauery wrote:
> 02 - acpiphp_ibm-v1.0.1e.patch
> 
>         This patch adds the first driver that actually uses the callback
>         function for attention LEDs that the acpiphp-attention patch
>         adds.  It searches the ACPI namespace for IBM hardware, sets up
>         the callbacks and sets up a handler to read ACPI events and
>         forward them on to /proc/acpi/event.  It also exports an ACPI
>         table that shows current hotplug status to userland.
> 
> 
>  Kconfig       |   12 +
>  Makefile      |    1
>  acpiphp_ibm.c |  474 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 487 insertions(+)
> 
> Signed-off-by: Vernon Mauery <vernux@us.ibm.com>

Applied, thanks.

greg k-h
