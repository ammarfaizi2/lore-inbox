Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTFPAqW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 20:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTFPAqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 20:46:21 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:57478 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S263179AbTFPAqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 20:46:21 -0400
Date: Mon, 16 Jun 2003 02:00:12 +0100
From: Ian Molton <spyro@f2s.com>
To: linux-kernel@vger.kernel.org
Subject: FRAMEBUFFER policy
Message-Id: <20030616020012.3f2d27dd.spyro@f2s.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

What is the policy as regards linux framebuffer drivers when presented
with a mode they cannot handle.

eg, suppose a driver can only handle even numbers of pixels and a
request is made for a mode with 639 pixels - should it allocate a 640
pixel wide mode?

or should it extend the height of a mode to allow hardware scrolling in
multiples of the font height?

Thanks.

-- 
Spyros lair: http://www.mnementh.co.uk/   ||||   Maintainer: arm26 linux

Do not meddle in the affairs of Dragons, for you are tasty and good with
ketchup.
