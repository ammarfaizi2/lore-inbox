Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932746AbWHOB0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbWHOB0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 21:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWHOB0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 21:26:42 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:17831 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932746AbWHOB0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 21:26:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=q55ZlSR5cYgy0uMQYJ27wlHlysNUhB2S0mTwfX3smIHdNtfIhkwPWaVUVQvfbjiQMjsnXwB/Cu7OkBxXOiCS97m+B484GdKjPsBrPSYFlQQbuk1yMPZZnPYUwfWQcpyQomtY0Q5Qw/JSWz++3I1CEA1hSasShKmPgVdzk1Za1WA=
Subject: Re: vga text console
From: "Antonino A. Daplas" <adaplas@gmail.com>
To: James C Georgas <jgeorgas@rogers.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1155604928.3948.8.camel@daplas.org>
References: <1155604313.8131.4.camel@Rainsong>
	 <1155604928.3948.8.camel@daplas.org>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 09:26:37 +0800
Message-Id: <1155605197.3948.10.camel@daplas.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 09:22 +0800, Antonino A. Daplas wrote:
> On Mon, 2006-08-14 at 21:11 -0400, James C Georgas wrote:
> > I can't seem to remove the VGA text console from my kernel
> > configuration. Can someone please enlighten me?
> 
> You can't. It is always part of the kernel (for X86 at least). What's
> your intention?

And correcting myself, you can configure out vgacon, but you have to
define CONFIG_EMBEDDED, and undefine CONFIG_VT.

Tony


