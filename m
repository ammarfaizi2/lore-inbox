Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWGSA7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWGSA7M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 20:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWGSA7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 20:59:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:40039 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932228AbWGSA7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 20:59:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=dvMdkR1dHAxNKQCXI7sarmB2rTlKCjngmuurT8pSJtg52167GBAZEnp0DBGxk8JWwHrM9ZnIUgGRH9XPuhxTHC/vVarJoJIhnIXM8cDf4YwDdu5ygQIpbOtaqZxtKwPCx9V583xmP3oAfS0EWpJW4F0y3zCsEBkqOWjzEnyYpc4=
Date: Wed, 19 Jul 2006 04:59:05 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, chas@cmf.nrl.navy.mil,
       miquel@df.uba.ar, kkeil@suse.de, benh@kernel.crashing.org,
       video4linux-list@redhat.com, rmk+mmc@arm.linux.org.uk,
       Neela.Kolli@engenio.com, jgarzik@pobox.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
Message-ID: <20060719005905.GC6815@martell.zuzino.mipt.ru>
References: <20060719004659.GA30823@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060719004659.GA30823@lumumba.uhasselt.be>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 02:46:59AM +0200, Panagiotis Issaris wrote:
> drivers: Conversions from kmalloc+memset to k(z|c)alloc.

This patch doesn't remove trivial wrappers around kzalloc.

