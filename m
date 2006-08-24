Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751559AbWHXOBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbWHXOBH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 10:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWHXOBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 10:01:06 -0400
Received: from kanga.kvack.org ([66.96.29.28]:19840 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751558AbWHXOBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 10:01:04 -0400
Date: Thu, 24 Aug 2006 10:00:43 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: "Serge E. Hallyn" <sergeh@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       kjhall@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       David Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>
Subject: Re: [PATCH 3/7] SLIM main patch
Message-ID: <20060824140043.GL28594@kvack.org>
References: <1156359937.6720.66.camel@localhost.localdomain> <20060823192733.GG28594@kvack.org> <1156365357.6720.87.camel@localhost.localdomain> <1156418815.3007.89.camel@localhost.localdomain> <20060824133248.GC15680@sergelap.austin.ibm.com> <20060824133733.GK28594@kvack.org> <20060824135803.GA32764@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824135803.GA32764@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 08:58:03AM -0500, Serge E. Hallyn wrote:
> Still not certain this is needed.  If you were able to write data to a
> pipe, then even though data may be in the buffer, the other end
> shouldn't be able to read it if it's own level were changed.

Then what is the benefit of the supposed revoke if it can be trivially 
bypassed?  Security has not been improved.  It is better not to provide 
a supposed feature than to offer it up so riddled with holes as to make 
it pointless.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
