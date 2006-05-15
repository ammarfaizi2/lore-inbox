Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbWEOPsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWEOPsQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWEOPsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:48:16 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:21273 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751513AbWEOPsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:48:14 -0400
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15 of 53] ipath - make some maximum values more sane
X-Message-Flag: Warning: May contain useful information
References: <480ceff18a886d7504a5.1147477380@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 08:48:12 -0700
In-Reply-To: <480ceff18a886d7504a5.1147477380@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Fri, 12 May 2006 16:43:00 -0700")
Message-ID: <adahd3ruw5f.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 15:48:12.0987 (UTC) FILETIME=[F920A0B0:01C67836]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > -unsigned int ib_ipath_max_cqes = 0xFFFF;
 > +unsigned int ib_ipath_max_cqes = 0x2FFFF;

You just added this limit in patch 8/53.  How about just fixing that
patch to do what you want?

 - R.
