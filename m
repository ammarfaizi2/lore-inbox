Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbTKBJFS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 04:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTKBJFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 04:05:18 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:65388 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S261592AbTKBJFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 04:05:15 -0500
Date: Sun, 2 Nov 2003 11:05:05 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: getrlimit for an arbitrary process?
Message-ID: <20031102090505.GB9015@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I did try google, but wasn't lucky, so...]

Is there a way to query/set getrlimit/setrlimit for an arbitrary process?
Not that I absolutely need it, but it would be nice to know if a daemon
really has resource limits in effect.

Couldn't find it under /proc, at least on 2.4.x.

(A 2.4.21-pre4aa3 server just locked up hard rather horrendeously when
SpamAssassin spamd decided to fork a couple of thousand processes... Looks
like I need sprinkle ulimit lines all over /etc/init.d/*.)

 
-- v --

v@iki.fi
