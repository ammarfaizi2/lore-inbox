Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWDZSag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWDZSag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWDZSag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:30:36 -0400
Received: from smtp-2.llnl.gov ([128.115.3.82]:58786 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S964800AbWDZSaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:30:35 -0400
From: Dave Peterson <dsp@llnl.gov>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/2] mm: serialize OOM kill operations
Date: Wed, 26 Apr 2006 11:29:33 -0700
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, riel@surriel.com, akpm@osdl.org
References: <200604251701.31899.dsp@llnl.gov> <200604261015.28922.dsp@llnl.gov> <200604262005.47387.ak@suse.de>
In-Reply-To: <200604262005.47387.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261129.33287.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 April 2006 11:05, Andi Kleen wrote:
> > Any suggestions for a location?
>
> ->flags

What struct are you looking in?  I don't see a ->flags member in
mm_struct.  Perhaps I should create a ->flags member and use one of
the bits?
