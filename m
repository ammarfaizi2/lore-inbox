Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261803AbSJDOPC>; Fri, 4 Oct 2002 10:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261804AbSJDOPC>; Fri, 4 Oct 2002 10:15:02 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:48658 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261803AbSJDOPB>; Fri, 4 Oct 2002 10:15:01 -0400
Date: Fri, 4 Oct 2002 15:20:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steve Pratt <slpratt@us.ibm.com>
Cc: Kevin M Corry <corryk@us.ibm.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: EVMS Submission for 2.5
Message-ID: <20021004152029.D30635@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steve Pratt <slpratt@us.ibm.com>, Kevin M Corry <corryk@us.ibm.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	evms-devel@lists.sourceforge.net
References: <OF479E53F5.0433681B-ON85256C47.0057D3AF@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF479E53F5.0433681B-ON85256C47.0057D3AF@pok.ibm.com>; from slpratt@us.ibm.com on Thu, Oct 03, 2002 at 11:09:37AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 11:09:37AM -0500, Steve Pratt wrote:
> None, really. Why does md put it's headers in include/linux/raid ???
> We can put them wherever.

MD is legacy code from the time where people still liked kernel headers
to /usr/include/linux

> Because it is getting crowded.  Why does every filesystem create it's own
> directory in fs?

Well, evms is not a single driver but a higher layer with lots of subdrivers.
E.g. once you start to use the MD code without copying it around it's in
drivers/md anyway and LVM! thæt is there currently will go away.

