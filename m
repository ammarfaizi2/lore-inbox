Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbUKVA2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUKVA2V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 19:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbUKVA0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 19:26:02 -0500
Received: from www22.dixiesys.com ([216.180.251.227]:11418 "EHLO
	www22.dixiesys.com") by vger.kernel.org with ESMTP id S261895AbUKVAZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 19:25:49 -0500
Subject: Re: [PATCH 475] HP300 LANCE
From: Sohail Somani <sohail@sohailsomani.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <20041121161244.1a5ff193.akpm@osdl.org>
References: <200410311003.i9VA3UMN009557@anakin.of.borg>
	 <20041101142245.GA28253@infradead.org>
	 <20041116084341.GA24484@infradead.org>
	 <20041116231248.5f61e489.akpm@osdl.org>
	 <Pine.GSO.4.61.0411211059500.19680@waterleaf.sonytel.be>
	 <20041121161244.1a5ff193.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 21 Nov 2004 16:25:15 -0800
Message-Id: <1101083116.20032.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-21 at 16:12 -0800, Andrew Morton wrote:

> +#define dio_resource_len(d) \
> +       ((d)->resource.end - (d)->resource.start)
> 
> but dio.h has:
> 
> #define dio_resource_len(d)   ((d)->resource.end-(z)->resource.start+1)
> 
> 
> Which is correct?

Where did z come from in the second definition anyway?

