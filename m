Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272685AbTG1G6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272687AbTG1G6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:58:23 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:17669 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272685AbTG1G5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:57:43 -0400
Date: Mon, 28 Jul 2003 08:12:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: console on by default if not embedded (save mucho pain)
Message-ID: <20030728081257.A1707@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <200307272002.h6RK215U029586@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307272002.h6RK215U029586@hraefn.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Jul 27, 2003 at 09:02:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That doesn't make sense, VT off is perfectly fine for servers.

With the select CONFIG_INPUT if CONFIG_VT we have a much better
fix for the misconfig in ow anyway.

