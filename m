Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUAHDsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 22:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUAHDsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 22:48:41 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:37049 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263584AbUAHDsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 22:48:41 -0500
Date: Thu, 8 Jan 2004 03:48:09 +0000
From: Dave Jones <davej@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Use of floating point in the kernel
Message-ID: <20040108034809.GA20616@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20040107235912.GA23812@ee.oulu.fi> <3FFCCFAE.8090302@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFCCFAE.8090302@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 07:34:06PM -0800, H. Peter Anvin wrote:

 > Has anyone considered asking the gcc people to add an -fno-fpu (or 
 > -mno-fpu) option, throwing an error if any FP instructions are used?

building with -msoft-float gets you this.

		Dave

