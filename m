Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266325AbUBLKt0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 05:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266327AbUBLKt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 05:49:26 -0500
Received: from holomorphy.com ([199.26.172.102]:33732 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266325AbUBLKtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 05:49:14 -0500
Date: Thu, 12 Feb 2004 02:48:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, tytso@thunk.org
Subject: Re: Updated dynamic pty patch available
Message-ID: <20040212104824.GA699@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, tytso@thunk.org
References: <402B168E.4020000@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="B0nZA57HJSoPbsHY"
Content-Disposition: inline
In-Reply-To: <402B168E.4020000@zytor.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--B0nZA57HJSoPbsHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 11, 2004 at 10:00:46PM -0800, H. Peter Anvin wrote:
> This version of the patch makes *both* legacy and Unix98 ptys configure 
> options (Unix98 only if EMBEDDED), and the number of legacy ptys is a 
> configuration option -- useful if you want to reduce the memory 
> footprint, or if you really wants lots of these guys (256 is no longer a 
> hard limit.)
> Additionally, I have added a sysctl option -- /proc/sys/kernel/pty/max 
> -- for limiting the number of Unix98 ptys.  It was way too effective a 
> DoS to eat up all kernel memory by opening /dev/ptmx repeatedly.  The 
> default is 4096, but it can be adjusted all the way up to 2^20 if desirable.

Comes up and boots just fine here on my target boxen. I'm glad to have it.
Bootlog from one of them attached.

I can send in console/etc. logs from both host and target of stress test
runs, if provided stress tests.


-- wli

--B0nZA57HJSoPbsHY
Content-Type: application/octet-stream
Content-Description: isogeny.log.1.gz
Content-Disposition: attachment; filename="isogeny.log.1.gz"
Content-Transfer-Encoding: base64

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

--B0nZA57HJSoPbsHY--
