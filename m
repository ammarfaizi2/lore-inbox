Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263863AbTCUWAq>; Fri, 21 Mar 2003 17:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263829AbTCUV7y>; Fri, 21 Mar 2003 16:59:54 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:40199 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263863AbTCUV7W>; Fri, 21 Mar 2003 16:59:22 -0500
Date: Fri, 21 Mar 2003 22:10:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH; tidy up make rpm
Message-ID: <20030321221024.A11422@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <200303212004.h2LK4hLH026223@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303212004.h2LK4hLH026223@hraefn.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 21, 2003 at 08:04:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 08:04:43PM +0000, Alan Cox wrote:
> +RPM 		:= $(shell if [ -x "/usr/bin/rpmbuild" ]; then echo rpmbuild; \
> +		    	else echo rpm; fi)

This make variable should be RPMBUILD, not RPM

