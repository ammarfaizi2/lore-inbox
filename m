Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVAYFdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVAYFdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 00:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVAYFdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 00:33:04 -0500
Received: from hqemgate03.nvidia.com ([216.228.112.143]:15117 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S261820AbVAYFdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 00:33:01 -0500
Date: Mon, 24 Jan 2005 23:31:04 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: davidm@hpl.hp.com, bgerst@didntduck.org,
       Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: inter_module_get and __symbol_get
Message-ID: <20050125053104.GF1716@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <16885.30810.787188.591830@napali.hpl.hp.com> <30494.1106606658@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30494.1106606658@ocs3.ocs.com.au>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
X-OriginalArrivalTime: 25 Jan 2005 05:31:59.0563 (UTC) FILETIME=[310899B0:01C5029F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 09:44:18AM +1100, kaos@ocs.com.au wrote:
> Weak references are only done once, when the module is loaded.  We
> already use weak references for static determination of symbol
> availability.  inter_module_* and __symbol_* are aimed at the dynamic
> reference problem, not static.

this is probably a stupid question, but how are weak references used?
Usually if a symbol is referenced by a module, but isn't resolved at
load time, the module refuses to load. dynamic references allow a way
to work around this for some applications, but I'm unfamiliar with
weak references being used in this regard.

or does that statement really mean "if we supported weak references,
they would only be done once..."

Thanks,
Terence 

