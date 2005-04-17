Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVDQQDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVDQQDO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 12:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVDQQDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 12:03:14 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:55816 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261342AbVDQQDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 12:03:12 -0400
Date: Sun, 17 Apr 2005 18:03:06 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why Ext2/3 needs immutable attribute?
Message-ID: <20050417160306.GB777@alpha.home.local>
References: <4ae3c14050417085473bd365f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c14050417085473bd365f@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2005 at 11:54:34AM -0400, Xin Zhao wrote:
> Why not simply unset the write bit for all three groups of users? 
> That seems to be enough to prevent file modification.
> 
> Immutable seems to only add one more protection level in case of
> misconfiguration on standard access right bits.  Is that right?

With immutable, even root cannot modify the file accidentely. It is
very useful for critical configuration files.

Willy

