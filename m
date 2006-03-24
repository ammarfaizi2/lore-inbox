Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbWCXOTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbWCXOTq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422855AbWCXOTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:19:46 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:9637 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S932633AbWCXOTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:19:45 -0500
Subject: Re: [RFC][UPDATED PATCH 2.6.16] [Patch 9/9] Generic netlink
	interface for delay accounting
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: balbir@in.ibm.com
Cc: Matt Helsley <matthltc@us.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <1143209518.5076.21.camel@jzny2>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142297791.5858.31.camel@elinux04.optonline.net>
	 <1142303607.24621.63.camel@stark> <1142304506.5219.34.camel@jzny2>
	 <20060322074922.GA1164@in.ibm.com> <1143122686.5186.27.camel@jzny2>
	 <20060324013229.GD13159@in.ibm.com>  <1143209518.5076.21.camel@jzny2>
Content-Type: text/plain
Organization: unknown
Date: Fri, 24 Mar 2006 09:19:42 -0500
Message-Id: <1143209982.5076.24.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-24-03 at 09:11 -0500, jamal wrote:

> Look at using proper macros instead of hard coding like you did.
> grep for something like RTA_SPACE and perhaps send a patch to make it
> generic for netlink.h
> 

actually Thomas already has this in netlink.h
Look at using things like:
nla_attr_size()

make sure padding is taken care of etc (read: use the right macros).

cheers,
jamal

