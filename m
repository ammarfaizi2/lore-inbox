Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752433AbWCFVYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbWCFVYP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbWCFVYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:24:15 -0500
Received: from kanga.kvack.org ([66.96.29.28]:60603 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751656AbWCFVYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:24:14 -0500
Date: Mon, 6 Mar 2006 16:18:54 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Dan Aloni <da-x@monatomic.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Status of AIO
Message-ID: <20060306211854.GM20768@kvack.org>
References: <20060306062402.GA25284@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306062402.GA25284@localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 08:24:03AM +0200, Dan Aloni wrote:
> Hello,
> 
> I'm trying to assert the status of AIO under the current version 
> of Linux 2.6. However by searching I wasn't able to find any 
> indication about it's current state. Is there anyone using it
> under a production environment?

For O_DIRECT aio things are pretty stable (barring a patch to improve -EIO 
handling).  The functionality is used by the various databases, so it gets 
a fair amount of exercise.

> I'd like to know how complete it is and whether socket AIO is
> adaquately supported.

Socket AIO is not supported yet, but it is useful to get user requests to 
know there is demand for it.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
