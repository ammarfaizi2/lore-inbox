Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTDYOZC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 10:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTDYOZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 10:25:02 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:30219 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263275AbTDYOZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 10:25:01 -0400
Date: Fri, 25 Apr 2003 15:37:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Gibson <hermes@gibson.dropbear.id.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>,
       David Hinds <dhinds@sonic.net>
Subject: Re: Update to orinoco driver (2.4)
Message-ID: <20030425153706.A2024@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Gibson <hermes@gibson.dropbear.id.au>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>,
	David Hinds <dhinds@sonic.net>
References: <20030423054636.GG25455@zax> <20030423060520.GI25455@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030423060520.GI25455@zax>; from hermes@gibson.dropbear.id.au on Wed, Apr 23, 2003 at 04:05:20PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void __exit exit_hermes(void)
> +{
> +}
> +
>  module_init(init_hermes);
> +module_exit(exit_hermes);

Please don't add exmpty functions without a reak good reason.

