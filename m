Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUK3BiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUK3BiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 20:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUK3BiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 20:38:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61355 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261582AbUK3Bhx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:37:53 -0500
Date: Tue, 30 Nov 2004 01:37:51 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] move OSS ac97_codec.h to sound/oss/
Message-ID: <20041130013750.GQ26051@parcelfarce.linux.theplanet.co.uk>
References: <20041130013139.GC19821@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130013139.GC19821@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 02:31:39AM +0100, Adrian Bunk wrote:
> As far as I can see, there's no good reason why the OSS ac97_codec.h 
> lives in include/linux/ .

Except for a bunch of constants defined there.  Are you sure that they
are not exposed to userland?
