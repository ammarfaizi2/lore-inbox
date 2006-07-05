Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWGERGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWGERGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbWGERGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:06:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28645 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964911AbWGERGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:06:43 -0400
Date: Wed, 5 Jul 2006 18:06:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: NULL terminate over-long /proc/kallsyms symbols
Message-ID: <20060705170635.GA16298@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Daniel Bonekeeper <thehazard@gmail.com>,
	Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <200607051859.41638.agruen@suse.de> <e1e1d5f40607051003v6b644e82p346c6e0661f39274@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e1d5f40607051003v6b644e82p346c6e0661f39274@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 01:03:14PM -0400, Daniel Bonekeeper wrote:
> Got a " You are not authorized to access bug #190296. To see this bug,
> you must first log in to an account with the appropriate permissions."
> on the referred bugzilla page.
> 
> What kind of symbol uses more than 127 characters, anyways ?

Yes, good question.  Maybe we should just put an upper limit on symbol
length in the module postprocessing so people don't do such stupid things.
