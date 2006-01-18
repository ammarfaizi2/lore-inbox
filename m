Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbWARPnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWARPnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWARPnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:43:13 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:10515 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1030349AbWARPnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:43:12 -0500
To: "Sean Hefty" <sean.hefty@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       openib-general@openib.org
Subject: Re: [openib-general] [PATCH 5/5] [RFC] Infiniband: connection
 abstraction
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX401yEXUIEAOeI00000043@orsmsx401.amr.corp.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 18 Jan 2006 07:43:09 -0800
In-Reply-To: <ORSMSX401yEXUIEAOeI00000043@orsmsx401.amr.corp.intel.com> (Sean
 Hefty's message of "Tue, 17 Jan 2006 15:44:48 -0800")
Message-ID: <adavewhwnhu.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 18 Jan 2006 15:43:09.0836 (UTC) FILETIME=[E21AB4C0:01C61C45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +struct ucma_file {
 > +	struct semaphore	mutex;

This should be a struct mutex instead, I think.

 > +static DECLARE_MUTEX(ctx_mutex);

Same here.

 - R.
