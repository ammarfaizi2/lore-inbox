Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWAIVFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWAIVFm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWAIVFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:05:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30613 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751352AbWAIVFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:05:41 -0500
Date: Mon, 9 Jan 2006 21:05:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: xfs: Makefile-linux-2.6 => Makefile?
Message-ID: <20060109210540.GA9972@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	linux-xfs@oss.sgi.com
References: <20060109164214.GA10367@mars.ravnborg.org> <20060109164611.GA1382@infradead.org> <20060109210105.GA13853@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109210105.GA13853@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#
> +# The xfs people like to share Makefile with 2.6 and 2.4.
> +# Utilise file named Kbuild file which has precedence over Makefile.
> +#
> +
> +include $(srctree)/$(obj)/Makefile-linux-2.6

What about just putting the content of the current Makefile-linux-2.6
into the Kbuild file directly?
