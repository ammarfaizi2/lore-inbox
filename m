Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWGMTRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWGMTRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWGMTRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:17:40 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:11696 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030301AbWGMTRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:17:39 -0400
Date: Thu, 13 Jul 2006 12:17:31 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Hans Reiser <reiser@namesys.com>
cc: Reiserfs mail-list <Reiserfs-List@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: short term task list for Reiser4
In-Reply-To: <44B42064.4070802@namesys.com>
Message-ID: <Pine.LNX.4.64.0607131215310.28976@schroedinger.engr.sgi.com>
References: <44B42064.4070802@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will there be any NUMA /SMP fixes? Reiserfs performance is severely 
impacted at higher processor counts by the mandatory centralized locking 
in both read and write paths in the filesystem.
