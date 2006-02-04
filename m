Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbWBDX51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbWBDX51 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWBDX51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:57:27 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20409
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932591AbWBDX50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:57:26 -0500
Date: Sat, 04 Feb 2006 15:57:23 -0800 (PST)
Message-Id: <20060204.155723.92202025.davem@davemloft.net>
To: akpm@osdl.org
Cc: pj@sgi.com, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060204155027.756bd372.akpm@osdl.org>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204155027.756bd372.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sat, 4 Feb 2006 15:50:27 -0800

> The !!  doesn't seem needed.  The name of this function implies that it
> returns a boolean, not a scalar.

As a historical note it used to be a common implementation error to
return "flag & bit" from this function instead of the correct
"(flag & bit) != 0".

