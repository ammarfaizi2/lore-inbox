Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbUAHMHr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 07:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUAHMHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 07:07:47 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:49421 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264375AbUAHMHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 07:07:46 -0500
Date: Thu, 8 Jan 2004 12:07:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: Nathan Scott <nathans@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Performance drop 2.6.0-test7 -> 2.6.1-rc2
Message-ID: <20040108120739.A8987@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Kasprzak <kas@informatics.muni.cz>,
	Nathan Scott <nathans@sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040107023042.710ebff3.akpm@osdl.org> <20040107215240.GA768@frodo> <20040108105427.E20265@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040108105427.E20265@fi.muni.cz>; from kas@informatics.muni.cz on Thu, Jan 08, 2004 at 10:54:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 10:54:27AM +0100, Jan Kasprzak wrote:
> 	I have done further testing:
> 
> - this is reliable: repeated boot back to 2.6.1-rc2 makes the problem
> 	appear again (high load, system slow has hell), booting back
> 	to -test7 makes it disappear.

Can you put fs/xfs from -test7 into the 2.6.1-rc tree and test with that?
