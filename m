Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWFNMpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWFNMpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 08:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWFNMpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 08:45:38 -0400
Received: from isilmar.linta.de ([213.239.214.66]:17537 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S964812AbWFNMph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 08:45:37 -0400
Date: Wed, 14 Jun 2006 14:45:35 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-pcmcia@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kthread: convert pcmcia_cs from kernel_thread
Message-ID: <20060614124535.GA14062@isilmar.linta.de>
Mail-Followup-To: "Serge E. Hallyn" <serue@us.ibm.com>,
	linux-pcmcia@lists.infradead.org,
	lkml <linux-kernel@vger.kernel.org>
References: <20060614120637.GD15061@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060614120637.GD15061@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 07:06:37AM -0500, Serge E. Hallyn wrote:
> Convert pcmcia_cs to use kthread instead of the deprecated
> kernel_thread.

Nack.

See
http://lists.infradead.org/pipermail/linux-pcmcia/2006-February/003259.html
or http://lkml.org/lkml/2006/2/14/395 for details.

	Dominik
