Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752332AbWCPKg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbWCPKg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbWCPKg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:36:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64897 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752110AbWCPKg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:36:56 -0500
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
From: Arjan van de Ven <arjan@infradead.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
In-Reply-To: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 11:36:53 +0100
Message-Id: <1142505413.3041.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 02:01 -0800, akpm@osdl.org wrote:
> From: Andrew Morton <akpm@osdl.org>
> 
> We have no less than 65 implementations of TRUE and FALSE in the tree, so the
> inevitable happened:


makes me wonder how many of these users should actually just use 0 and 1
directly (but that's a long during janitor task I guess)

