Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVDEKBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVDEKBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVDEJ5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:57:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11231 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261645AbVDEJzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:55:14 -0400
Date: Tue, 5 Apr 2005 10:54:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Dave Airlie <airlied@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405095445.GA29246@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Mackerras <paulus@samba.org>, Dave Airlie <airlied@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050405000524.592fc125.akpm@osdl.org> <20050405074405.GE26208@infradead.org> <21d7e99705040502073dfa5e5@mail.gmail.com> <16978.22617.338768.775203@cargo.ozlabs.ibm.com> <20050405093020.GA28620@infradead.org> <16978.24070.786761.641930@cargo.ozlabs.ibm.com> <20050405094535.GA29095@infradead.org> <16978.24509.527688.799274@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16978.24509.527688.799274@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 07:51:57PM +1000, Paul Mackerras wrote:
> Christoph Hellwig writes:
> 
> > Please make it a module option so it doesn't regress everyone for your
> > specific needs.
> 
> Sorry, I don't follow you.

E.g. on my ia64 box CONFIG_COMPAT is set because I have support compiled
in for running i386 apps.  But I don't want dri to hand out 32bit handles
everywhere just because of that, because I most certainly won't be running
i386 OpenGL apps.
