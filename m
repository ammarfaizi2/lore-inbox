Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWHXNhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWHXNhl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWHXNhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:37:41 -0400
Received: from kanga.kvack.org ([66.96.29.28]:41197 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751523AbWHXNhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:37:40 -0400
Date: Thu, 24 Aug 2006 09:37:33 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Serge E. Hallyn" <sergeh@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, kjhall@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       David Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>
Subject: Re: [PATCH 3/7] SLIM main patch
Message-ID: <20060824133733.GK28594@kvack.org>
References: <1156359937.6720.66.camel@localhost.localdomain> <20060823192733.GG28594@kvack.org> <1156365357.6720.87.camel@localhost.localdomain> <1156418815.3007.89.camel@localhost.localdomain> <20060824133248.GC15680@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824133248.GC15680@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 08:32:48AM -0500, Serge E. Hallyn wrote:
> > You also have to deal with existing mmap() mappings and outstanding I/O.
> 
> That she does.

Outstanding I/O is not revoked.  Any in-progress I/O continues.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
