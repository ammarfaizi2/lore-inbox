Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbVKBHdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbVKBHdF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbVKBHdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:33:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26056 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932626AbVKBHdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:33:03 -0500
Date: Wed, 2 Nov 2005 02:32:51 -0500
From: Dave Jones <davej@redhat.com>
To: Rob Landley <rob@landley.net>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: echo 0 > /proc/sys/vm/swappiness triggers OOM killer under 2.6.14.
Message-ID: <20051102073251.GB23297@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rob Landley <rob@landley.net>, Robert Hancock <hancockr@shaw.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <53vpu-s9-17@gated-at.bofh.it> <4366E99D.7070606@shaw.ca> <200511010237.01737.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511010237.01737.rob@landley.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 02:37:01AM -0600, Rob Landley wrote:


 > oom-killer: gfp_mask=0x400d2, order=0

something explicitly asked for a highmem page.

 > 0 pages of HIGHMEM

You don't have any.

Calling the oom-killer in this situation seems drastic though.

		Dave

