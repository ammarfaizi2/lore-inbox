Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbVBYTSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVBYTSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 14:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVBYTSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 14:18:41 -0500
Received: from ns1.s2io.com ([142.46.200.198]:5788 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S262785AbVBYTSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 14:18:12 -0500
Subject: Re: UDP optimization
From: Dmitry Yusupov <dima@neterion.com>
To: shabanip <shabanip@avapajoohesh.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <46548.69.93.110.242.1109328682.squirrel@69.93.110.242>
References: <46548.69.93.110.242.1109328682.squirrel@69.93.110.242>
Content-Type: text/plain
Organization: Neterion, Inc
Date: Fri, 25 Feb 2005 11:17:57 -0800
Message-Id: <1109359077.13087.64.camel@beastie>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -6.1
X-Spam-Outlook-Score: ()
X-Spam-Features: BAYES_00,EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,REPLY_WITH_QUOTES
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as UDP HW acceleration is concerned we need to modify/verify that
Linux TCP/IP stack capable of:

1) Partial checksumming on receive
2) Checksumming over fragments on transmit

And find the NIC which capable of doing that. s2io/neterion hw do
supports those features.

Regards,
Dima

Without those two, I doubt you will 

On Fri, 2005-02-25 at 14:21 +0330, shabanip wrote:
> as i know there are many ways to optimize and tune TCP parameters in kernel
> but how can i tune and optimize UDp performance?
> thanks,
> Payam Shabanian
> shabanip -at- avapajoohesh.com


