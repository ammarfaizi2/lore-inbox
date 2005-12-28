Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVL1AIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVL1AIr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 19:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbVL1AIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 19:08:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55485 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932408AbVL1AIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 19:08:46 -0500
Date: Tue, 27 Dec 2005 19:08:32 -0500
From: Dave Jones <davej@redhat.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove unneeded packed attribute
Message-ID: <20051228000832.GC6917@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <43B1D5E0.90908@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43B1D5E0.90908@didntduck.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 07:01:36PM -0500, Brian Gerst wrote:
 > GCC 4.1 gives the following warning:
 > include/asm/mpspec.h:79: warning: ‘packed’ attribute ignored for field 
 > of type ‘unsigned char[5u]’
 > 
 > The packed attribute isn't really necessary anyways so just remove it.
 > 
 > Signed-off-by: Brian Gerst <bgerst@didntduck.org>

We've been carrying exactly the same diff in the Fedora rawhide kernel for
the last week or two.

ACKed by: Dave Jones <davej@redhat.com>

		Dave

