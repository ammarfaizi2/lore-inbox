Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbVLETML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVLETML (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVLETMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:12:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39899 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932512AbVLETMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:12:08 -0500
Date: Mon, 5 Dec 2005 19:11:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Arch specific zone reclaim framework
Message-ID: <20051205191159.GB28433@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
	torvalds@osdl.org, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20051205190104.12037.69672.sendpatchset@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205190104.12037.69672.sendpatchset@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nack.  Arch control over VM reclaim logic will load to a total mess with VM
logic all over arch.  Please introduce a framework that allows individual
machines control parameters, but procedural callouts are a big no-no.
