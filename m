Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTJNVHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTJNVHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:07:42 -0400
Received: from smtp5.hy.skanova.net ([195.67.199.134]:19936 "EHLO
	smtp5.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262745AbTJNVHl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:07:41 -0400
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Date: Tue, 14 Oct 2003 23:11:36 +0200
User-Agent: KMail/1.5.9
References: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>
In-Reply-To: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200310142311.36472.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 October 2003 18.27, Maciej Zenczykowski wrote:
> Of course part of the problem is that by designing the kernel for high mem
> situations we're using more memory hogging algorithms.  It's a simple
> matter of features vs mem footprint.

Algorithms using lots of memory should be avoided even for newer computers.
Cache misses HURTS.

That is why -Os can be a better compilation option than -O2 !

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
