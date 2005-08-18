Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVHRVYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVHRVYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVHRVYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:24:15 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:34522 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932456AbVHRVYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:24:14 -0400
Date: Thu, 18 Aug 2005 14:23:48 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-cluster@redhat.com
Subject: Re: [PATCH 1/3] dlm: use configfs
Message-ID: <20050818212348.GW21228@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050818060750.GA10133@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818060750.GA10133@redhat.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, Aug 18, 2005 at 02:07:50PM +0800, David Teigland wrote:
> +/*
> + * /config/dlm/<cluster>/spaces/<space>/nodes/<node>/nodeid
> + * /config/dlm/<cluster>/spaces/<space>/nodes/<node>/weight
> + * /config/dlm/<cluster>/comms/<comm>/nodeid
> + * /config/dlm/<cluster>/comms/<comm>/local
> + * /config/dlm/<cluster>/comms/<comm>/addr
> + * The <cluster> level is useless, but I haven't figured out how to avoid it.
> + */
	So what happened to factoring out the common parts of
ocfs2_nodemanager? I was quite a big fan of that approach :) Or am I just
misunderstanding what these patches do?
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
