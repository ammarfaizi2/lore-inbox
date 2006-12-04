Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937119AbWLDQu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937119AbWLDQu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937130AbWLDQu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:50:58 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:60864 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937119AbWLDQu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:50:57 -0500
Subject: Re: [PATCH  v2 03/13] Provider Methods and Data Structures
From: Steve Wise <swise@opengridcomputing.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Arjan van de Ven <arjan@infradead.org>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <adaodqjip91.fsf@cisco.com>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
	 <20061202224947.27014.59189.stgit@dell3.ogc.int>
	 <1165147639.3233.211.camel@laptopd505.fenrus.org>
	 <1165249706.32724.35.camel@stevo-desktop>  <adaodqjip91.fsf@cisco.com>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 10:50:48 -0600
Message-Id: <1165251048.32724.37.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 08:45 -0800, Roland Dreier wrote:
>  > Roland, I think at one time we were talking about changing the Core to
>  > better handle this?  Either with attributes/capabilities that the low
>  > level driver can set, or by set these method ptrs to NULL and the core
>  > should handle it in the wrapper function...
> 
> Yes, it would make sense to change the midlayer so we have different
> sets of mandatory functions for IB and iWARP drivers.  For example,
> the iwcm functions probably should be mandatory for iWARP devices, right?
> 

Yes. The iWARP devices must all support the iwcm methods for sure.



