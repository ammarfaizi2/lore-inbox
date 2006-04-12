Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWDLQFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWDLQFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 12:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWDLQFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 12:05:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:52922 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751079AbWDLQFu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 12:05:50 -0400
Date: Wed, 12 Apr 2006 09:05:58 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Mike Kravetz <mjkravetz@verizon.net>, Andrew Morton <akpm@osdl.org>,
       Arnd Bergmann <arnd@arndb.de>, Joel H Schopp <jschopp@us.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Lhms-devel] Re: [PATCH] sparsemem interaction with memory add bug fixes
Message-ID: <20060412160558.GA3146@w-mikek2.ibm.com>
References: <20060412023347.GA9343@w-mikek2.ibm.com> <1144853164.31255.82.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144853164.31255.82.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 07:46:04AM -0700, Dave Hansen wrote:
> Just out of curiosity.  Can these issues be revealed with current code,
> or do they only show up with the cell changes?

Yes, you could hit either of these doing memory adds with the current
code.  The follow up issue of adding sub-section amounts of memory is
cell specific.

-- 
Mike
