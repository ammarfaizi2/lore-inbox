Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751863AbWCJRFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbWCJRFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWCJRFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:05:25 -0500
Received: from mx.pathscale.com ([64.160.42.68]:2008 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751863AbWCJRFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:05:24 -0500
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <gregkh@suse.de>
Cc: Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20060310165813.GB11382@suse.de>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	 <ada8xrjfbd8.fsf@cisco.com>
	 <1141948367.10693.53.camel@serpentine.pathscale.com>
	 <20060310004505.GB17050@suse.de>
	 <1141951725.10693.88.camel@serpentine.pathscale.com>
	 <20060310010403.GC9945@suse.de>
	 <1141965696.14517.4.camel@camp4.serpentine.com> <ada7j72detl.fsf@cisco.com>
	 <1141998230.28926.4.camel@localhost.localdomain>
	 <20060310165813.GB11382@suse.de>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 10 Mar 2006 09:05:19 -0800
Message-Id: <1142010319.29925.30.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 08:58 -0800, Greg KH wrote:

> You keep an internal list of devices, if you really need to do such a
> thing.

OK.  I do think we need it, because we have a dozen or so cases where we
do "iterate over all of the known devices".

> It's just the "disconnect" PCI function being called, which can happen
> at any time.

Thanks.

	<b

