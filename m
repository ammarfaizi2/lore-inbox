Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVCOF37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVCOF37 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 00:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVCOF36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 00:29:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29357 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262262AbVCOF3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 00:29:41 -0500
Date: Tue, 15 Mar 2005 05:29:36 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, roland@redhat.com,
       sivanich@sgi.com
Subject: Re: Exports to enable clock driver modules
Message-ID: <20050315052936.GA26247@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, roland@redhat.com, sivanich@sgi.com
References: <Pine.LNX.4.58.0503142034190.16107@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503142034190.16107@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 08:37:43PM -0800, Christoph Lameter wrote:
> The following exports are necessary to allow loadable modules to define
> new clocks. Without these the mmtimer driver cannot be build
> correctly as a module (there is another mmtimer specific fix necessary to
> get  it to build properly but that will be a separate patch):

I'd say just disallow modular mmtimer instead.

