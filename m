Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbTJSNZo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 09:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTJSNZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 09:25:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40719 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262133AbTJSNZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 09:25:43 -0400
Date: Sun, 19 Oct 2003 14:25:37 +0100
From: Dave Jones <davej@redhat.com>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-2.6.0-test{7-8} and radeon drm segfault
Message-ID: <20031019132536.GF8018@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Louis Garcia <louisg00@bellsouth.net>, linux-kernel@vger.kernel.org
References: <1066518605.4195.11.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066518605.4195.11.camel@tiger>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 07:10:05PM -0400, Louis Garcia wrote:
 > I've been playing with kernel-2.6 on redhat's latest beta. With my
 > radeon 7500 drm works great. When I boot to kernel-2.6 latest, I
 > modprobe agpgart, intel-agp and radeon. Startx and run glxinfo
 > and glxgears and both segfault. Anyone else seeing this? This
 > also happens if these are build statically.

Check dmesg after they segfault, there may be a kernel oops
in there.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
