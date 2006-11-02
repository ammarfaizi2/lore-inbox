Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751852AbWKBQNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbWKBQNj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 11:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbWKBQNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 11:13:39 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:11671 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751852AbWKBQNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 11:13:38 -0500
Date: Thu, 2 Nov 2006 08:13:28 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Conke Hu <conke.hu@amd.com>, Jun Sun <jsun@junsun.net>,
       linux-kernel@vger.kernel.org
Subject: RE: Can Linux live without DMA zone?
In-Reply-To: <1162451591.27131.2.camel@taijtu>
Message-ID: <Pine.LNX.4.64.0611020812340.6796@schroedinger.engr.sgi.com>
References: <FFECF24D2A7F6D418B9511AF6F358602F2D4E1@shacnexch2.atitech.com>
 <1162451591.27131.2.camel@taijtu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That code is in 2.6.19-rc4-mm1. If you clear CONFIG_ZONE_DMA then you 
wont have a DMA zone anymore.
