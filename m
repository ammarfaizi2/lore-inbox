Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266353AbUH0P5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266353AbUH0P5P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266310AbUH0P4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:56:25 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:64266 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266386AbUH0Pyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:54:45 -0400
Date: Fri, 27 Aug 2004 16:54:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Latest Altix I/O code reorganization code
Message-ID: <20040827165443.A32567@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <411AAABB.8070707@sgi.com> <412F4EC9.7050003@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <412F4EC9.7050003@sgi.com>; from pfg@sgi.com on Fri, Aug 27, 2004 at 10:10:01AM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 10:10:01AM -0500, Patrick Gefre wrote:
> 
> This is an update to our last set of patches. I've added some comments from the
> last review and another synopsis of the patches. The individual patches will
> follow this email.

Matthew Wilcox suggested we should really review it as completely new
code.  So maybe you should split it into one patch that kills all old
code ånd one that adds new code.  Note that I mean all all code includeing
the headers which provides a nice opporuntiy to move all of them that
aren't public interface inside arch/ia64/sn/


