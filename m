Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTISQGg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 12:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbTISQGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 12:06:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:29413 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261606AbTISQGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 12:06:35 -0400
Subject: 2.6.0-test5-mm3 passes dbt2
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, Dave Olien <dmo@osdl.org>,
       Mary Edie Meredith <maryedie@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030918202834.4d700b12.akpm@osdl.org>
References: <1063933406.1984.39.camel@ibm-c.pdx.osdl.net>
	 <20030919032739.GA3313@in.ibm.com>  <20030918202834.4d700b12.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1063987587.1984.58.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Sep 2003 09:06:27 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The dbt2 test completed successfully on test5-mm3.  STP ran it
automatically when it saw -mm3 come out -- got to like automatic
testing.

The O_SYNC + O_DIRECT is a strange case.  I'll run some AIO tests using
O_DIRECT and O_SYNC and let you know if I see anything bad.

Daniel

On Thu, 2003-09-18 at 20:28, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> > I'm hoping that the patch I'd sent you yesterday might fix this.
> >  In the case of O_DIRECT, pagevec_lookup would likely not find
> >  the pages in the cache -- so this might just be the same bug
> >  that I ran into.
> 
> OK.  Daniel can you retest -mm3?   I'll get that out tonight.

