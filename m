Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262755AbTCUVEn>; Fri, 21 Mar 2003 16:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262739AbTCUVDc>; Fri, 21 Mar 2003 16:03:32 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:16134 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263791AbTCUSsE>; Fri, 21 Mar 2003 13:48:04 -0500
Date: Fri, 21 Mar 2003 18:59:05 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: module for legacy PC9800 ide
Message-ID: <20030321185905.A7664@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <200303211928.h2LJSjWS025795@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303211928.h2LJSjWS025795@hraefn.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 21, 2003 at 07:28:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 07:28:45PM +0000, Alan Cox wrote:
> +	/* These ports are probably used by IDE I/F.  */
> +	request_region(0x430, 1, "ide");
> +	request_region(0x435, 1, "ide");

No error chechking?

