Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUFWWB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUFWWB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUFWWBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:01:11 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:2314 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261300AbUFWV6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:58:16 -0400
Date: Wed, 23 Jun 2004 23:58:12 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alphabet of kernel source
Message-ID: <20040623215812.GD3072@pclin040.win.tue.nl>
References: <20040623140628.3f1abfe9@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623140628.3f1abfe9@lembas.zaitcev.lan>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 02:06:28PM -0700, Pete Zaitcev wrote:

> Anyhow, long story short, this got me thinking... What is the charset
> and the encoding of the actual source? I saw quite a discussion about
> the filenames, but this is different. I am sorry if this was discussed
> previously.

This has come up repeatedly. As far as I recall, Linus has never said
anything. The de facto situation can be seen by just inspecting the
MAINTAINERS file. Kai Makisara has a diaeresis on the first vowel of
his last name. Today (2.6.6) that is still coded in ISO 8859-1.

In old discussions people who disliked 8859-1 expressed strong preference
for plain ASCII (possibly with TeX-like escape sequences for non-ASCII).
These days it seems that, if anything is changed, the only reasonable action
would be to switch to UTF-8.

Andries
