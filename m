Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbTIXDrx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbTIXDrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:47:53 -0400
Received: from holomorphy.com ([66.224.33.161]:12676 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261434AbTIXDrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:47:51 -0400
Date: Tue, 23 Sep 2003 20:48:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Trivial Russell <trivial@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Fix comment in parse_hex_value
Message-ID: <20030924034858.GI4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Trivial Russell <trivial@rustcorp.com.au>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030924032926.4485D2C56E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030924032926.4485D2C56E@lists.samba.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 12:50:45PM +1000, Rusty Trivial Russell wrote:
> -	 * Parse the first 8 characters as a hex string, any non-hex char
> +	 * Parse the first HEX_DIGITS characters as a hex string, any non-hex char

This is good; thanks for catching it. I was over this recently and
should have cleaned it up while I was there.


-- wli
