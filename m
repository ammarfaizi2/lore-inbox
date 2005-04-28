Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVD1MvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVD1MvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 08:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVD1MvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 08:51:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18575 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261589AbVD1MvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 08:51:17 -0400
Subject: Re: [PATCH 0/7] dlm: overview
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Stephen Tweedie <sct@redhat.com>, Mark Fasheh <mark.fasheh@oracle.com>,
       David Teigland <teigland@redhat.com>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050427132343.GX4431@marowsky-bree.de>
References: <20050425151136.GA6826@redhat.com>
	 <20050425203952.GE25002@ca-server1.us.oracle.com>
	 <20050426053930.GA12096@redhat.com>
	 <20050426184845.GA938@ca-server1.us.oracle.com>
	 <20050427132343.GX4431@marowsky-bree.de>
Content-Type: text/plain
Message-Id: <1114692656.1920.20.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 28 Apr 2005 13:50:56 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-04-27 at 14:23, Lars Marowsky-Bree wrote:

> Well, frankly, recovery time of the DLM mostly will depend on the speed
> of the membership algorithm and timings used. 

Sometimes.  But I've encountered systems with over ten million active
locks in use at once.  Those took a _long_ time to recover the DLM;
sorting out membership was a trivial part of the time!

--Stephen


