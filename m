Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263431AbTJQMdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 08:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbTJQMdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 08:33:05 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:47111 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263431AbTJQMdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 08:33:03 -0400
Date: Fri, 17 Oct 2003 13:33:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Denis Zaitsev <zzz@anda.ru>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH TRIVIAL] Compile error in 2.4.22 without PCI
Message-ID: <20031017133301.B27349@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Denis Zaitsev <zzz@anda.ru>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20031015003036.A10226@natasha.ward.six>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031015003036.A10226@natasha.ward.six>; from zzz@anda.ru on Wed, Oct 15, 2003 at 12:30:36AM +0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 12:30:36AM +0600, Denis Zaitsev wrote:
> I have these warnings when I'm compiling 2.4.22 for a 486 EISA system:
> 
> aic7xxx_osm.c: In function `ahc_softc_comp':
> aic7xxx_osm.c:1560: warning: implicit declaration of function `ahc_get_pci_bus'
> aic7xxx_osm.c:1568: warning: implicit declaration of function `ahc_get_pci_slot'
> 
> And then the make finishes with an error, because these functions
> really exist only if the PCI support is turned on.
> 
> The patch below fixes this.  And the same patch fits for the 2.6
> kernels.  Please, apply it.

You probably want to send this to Justin, the driver Maintainer.  If he
doesn't reply in say a week I´d suggest submitting it to Marcelo as it's
obviously correct.

