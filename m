Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbTDHFtJ (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 01:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263947AbTDHFtJ (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 01:49:09 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:10769 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263540AbTDHFtI (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 01:49:08 -0400
Date: Tue, 8 Apr 2003 07:00:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: SET_MODULE_OWNER?
Message-ID: <20030408070039.A10964@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Jeff Garzik <jgarzik@pobox.com>, zwane@linuxpower.ca,
	linux-kernel@vger.kernel.org
References: <3E923390.9010206@pobox.com> <20030408035210.02D142C06E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030408035210.02D142C06E@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Apr 08, 2003 at 01:46:52PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 01:46:52PM +1000, Rusty Russell wrote:
> Christoph went through and substituted try_inc_mod_count to
> try_module_get, for no gain, and broke backwards compatibility.

You can still implement try_module_get and module_put on older
kernels.  Jeff mostly cares about net drivers anyway that use neither :)

