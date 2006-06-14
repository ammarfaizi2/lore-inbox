Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWFNMwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWFNMwc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 08:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWFNMwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 08:52:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:45728 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932347AbWFNMwb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 08:52:31 -0400
Date: Wed, 14 Jun 2006 07:50:48 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>, linux-pcmcia@lists.infradead.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kthread: convert pcmcia_cs from kernel_thread
Message-ID: <20060614125048.GH15061@sergelap.austin.ibm.com>
References: <20060614120637.GD15061@sergelap.austin.ibm.com> <20060614124535.GA14062@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060614124535.GA14062@isilmar.linta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dominik Brodowski (linux@dominikbrodowski.net):
> On Wed, Jun 14, 2006 at 07:06:37AM -0500, Serge E. Hallyn wrote:
> > Convert pcmcia_cs to use kthread instead of the deprecated
> > kernel_thread.
> 
> Nack.
> 
> See
> http://lists.infradead.org/pipermail/linux-pcmcia/2006-February/003259.html
> or http://lkml.org/lkml/2006/2/14/395 for details.

Ok - so if we keep the thread_done completion in front of the main
loop in pccardd to check for that error, will that be sufficient?

thanks,
-serge
