Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbTEXGPg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 02:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbTEXGPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 02:15:36 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:62983 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264092AbTEXGPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 02:15:35 -0400
Date: Sat, 24 May 2003 07:28:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] static MAX_MP_BUSSES increase for Summit boxes
Message-ID: <20030524072836.A12945@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Cleverdon <jamesclv@us.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <200305232027.26945.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305232027.26945.jamesclv@us.ibm.com>; from jamesclv@us.ibm.com on Fri, May 23, 2003 at 08:27:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 08:27:26PM -0700, James Cleverdon wrote:
> The dynamic MAX_MP_BUSSES fix for v2.4 never made it into 2.5.  x440s with 
> RXE100s and 32-way x445s without can easily overflow it.
> 
> Here's a static patch:

Umm, no.  Please forward port the dynamic MAX_MP_BUSSES changes instead of
such a hack.

