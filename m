Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTHYToc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 15:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTHYToc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 15:44:32 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:50180 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262196AbTHYTo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 15:44:28 -0400
Date: Mon, 25 Aug 2003 20:44:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: herbert@13thfloor.at, linux-kernel@vger.kernel.org
Subject: Re: [OT] sizeof C types ...
Message-ID: <20030825204426.A11208@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>, herbert@13thfloor.at,
	linux-kernel@vger.kernel.org
References: <20030825191339.GA28525@www.13thfloor.at> <20030825122906.79d755d4.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030825122906.79d755d4.rddunlap@osdl.org>; from rddunlap@osdl.org on Mon, Aug 25, 2003 at 12:29:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 12:29:06PM -0700, Randy.Dunlap wrote:
> Also see Ch. 10 of the LDD book:
>   http://www.xml.com/ldd/chapter/book/ch10.html

Well, that chapter has some issue.  It talks of sparc64 when actually
meaning a sparc32 userland on sparc64, and it missed the 2.6 merge of
mips64 into mips as mips can now have either 32 or 64bit longs and
pointers.

