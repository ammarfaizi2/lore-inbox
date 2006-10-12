Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWJLV5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWJLV5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWJLV5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:57:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49326 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751149AbWJLV5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:57:52 -0400
Message-ID: <452EBA55.8000209@sandeen.net>
Date: Thu, 12 Oct 2006 16:57:41 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Eric Sandeen <esandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Jan Kara <jack@suse.cz>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
References: <20061009225036.GC26728@redhat.com>	<20061010141145.GM23622@atrey.karlin.mff.cuni.cz>	<452C18A6.3070607@redhat.com>	<1160519106.28299.4.camel@dyn9047017100.beaverton.ibm.com>	<452C4C47.2000107@sandeen.net>	<20061011103325.GC6865@atrey.karlin.mff.cuni.cz>	<452CF523.5090708@sandeen.net>	<20061011142205.GB24508@atrey.karlin.mff.cuni.cz>	<1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com>	<452DAA26.6080200@redhat.com>	<20061012122820.GK9495@atrey.karlin.mff.cuni.cz> <20061012094036.e1a3f9f1.akpm@osdl.org> <452EA06F.4060701@redhat.com> <452EB9C5.4000404@us.ibm.com>
In-Reply-To: <452EB9C5.4000404@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:

> This is exactly  the solution I proposed earlier (to check 
> buffer_mapped() before calling submit_bh()).
> But at that time, Jan pointed out that the whole handling is wrong.
> 
> But if this is the only case we need to handle, I am okay with this band 
> aid :)

Doh!

And we come full circle... ok let me go reread that thread, it got long
enough I had to swap out... :)

-Eric
