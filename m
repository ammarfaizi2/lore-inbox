Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUCQTe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 14:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUCQTe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 14:34:28 -0500
Received: from verein.lst.de ([212.34.189.10]:3257 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262005AbUCQTeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 14:34:25 -0500
Date: Wed, 17 Mar 2004 20:34:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Justin T. Gibbs" <Justin_Gibbs@adaptec.com>, linux-raid@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: "Enhanced" MD code avaible for review]
Message-ID: <20040317193416.GA24542@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Jeff Garzik <jgarzik@pobox.com>,
	"Justin T. Gibbs" <Justin_Gibbs@adaptec.com>,
	linux-raid@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <405899E8.8070806@pobox.com> <20040317183756.GA23667@lst.de> <2241002704.1079549645@aslan.btc.adaptec.com> <20040317190117.GA23968@lst.de> <2260532704.1079550351@aslan.btc.adaptec.com> <20040317190916.GA24118@lst.de> <4058A6FB.6080602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4058A6FB.6080602@pobox.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2004 at 02:28:59PM -0500, Jeff Garzik wrote:
> If early userspace isn't ready, it sounds like a choice between 
> "nothing" and "it works".
> 
> We want a clean, tasteful solution, sure.  But I think we can work 
> within the confines of the existing 2.6 API, and not postpone this stuff 
> under early userspace is ready.

Umm, early userspace works nicely, you don't need the klibc and
initramfs buzzwords for that, good 'ol initrd still works and people
actually use it, e.g. for dm.

