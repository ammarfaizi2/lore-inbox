Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbTFORHF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTFORGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:06:38 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:24746 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262437AbTFORGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:06:03 -0400
Date: Sun, 15 Jun 2003 19:19:55 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Brian Jackson <brian@mdrx.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make cramfs look less hostile
Message-ID: <20030615171955.GF1063@wohnheim.fh-wedel.de>
References: <20030615160524.GD1063@wohnheim.fh-wedel.de> <200306151157.10493.brian@mdrx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200306151157.10493.brian@mdrx.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 June 2003 11:57:10 -0500, Brian Jackson wrote:
> 
> What about making it "cramfs: magic not found or incorrect\n". That test could 
> result in incorrect magic (not just missing magic), couldn't it?

Yes, but truth is not my goal. :)

The only point of that output is to give someone an idea what might be
wrong when the kernel boots, but it never reaches userspace.  Keep it
short, crisp, and harmless to those eyes not needing it.  Will try to
code up something longer.

Jörn

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."
