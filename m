Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUCOIjO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 03:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUCOIjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 03:39:14 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:49576 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S262351AbUCOIjN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 03:39:13 -0500
In-Reply-To: <1079153403.2348.82.camel@gaston>
References: <20040313041547.GB11512@staidm.org> <1079153403.2348.82.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v612)
Message-Id: <2412BC40-765C-11D8-8673-000A95A4DC02@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Bryan Rittmeyer <bryan@staidm.org>, Paul Mackerras <paulus@samba.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ppc32 copy_to_user dcbt fixup
Date: Mon, 15 Mar 2004 09:38:32 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.612)
X-MIMETrack: Itemize by SMTP Server on D12ML046/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 15/03/2004 09:38:27,
	Serialize by Router on D12ML046/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 15/03/2004 09:38:30,
	Serialize complete at 15/03/2004 09:38:30
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It would be wise to make the dcbz as long as
> possible in "advance" before the actual write to the cache line.

And use dcbzl instead, if available...


Segher

