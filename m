Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUGNXQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUGNXQv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 19:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUGNXK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 19:10:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:39125 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266009AbUGNXJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 19:09:36 -0400
Date: Wed, 14 Jul 2004 15:52:19 -0700
From: Greg KH <greg@kroah.com>
To: Vernon Mauery <vernux@us.ibm.com>
Cc: pcihpd <pcihpd-discuss@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <gregkh@us.ibm.com>,
       Pat Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Jess Botts <botts@us.ibm.com>
Subject: Re: [PATCH] [1/2] acpiphp extension for 2.6.7 (final)
Message-ID: <20040714225219.GA3398@kroah.com>
References: <1087934028.2068.57.camel@bluerat> <200407071147.57604@bilbo.math.uni-mannheim.de> <1089216410.24908.5.camel@bluerat> <200407081209.42927@bilbo.math.uni-mannheim.de> <1089328415.2089.194.camel@bluerat> <20040708232827.GA20755@kroah.com> <1089331956.2089.253.camel@bluerat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089331956.2089.253.camel@bluerat>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 05:12:36PM -0700, Vernon Mauery wrote:
> 01 - acpiphp-attention-v0.1e.patch
> 
>         This patch adds the ability to register callback functions with
>         the acpiphp core to set and get the current attention LED
>         status.  The reason this is needed is because there is not set
>         ACPI standard for how this is done so each hardware platform may
>         implement it differently.  To keep hardware specific code out of
>         acpiphp, we allow other modules to register their code with it.
> 
> 
>  acpiphp.h      |   16 +++++++
>  acpiphp_core.c |  127 ++++++++++++++++++++++++++++++++++++++++++++-------------
>  acpiphp_glue.c |   14 ------
>  3 files changed, 115 insertions(+), 42 deletions(-)
> 
> Signed-off-by: Vernon Mauery <vernux@us.ibm.com>

Applied, thanks.

greg k-h
