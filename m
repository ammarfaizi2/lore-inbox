Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWDWSkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWDWSkM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 14:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWDWSkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 14:40:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60631 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751439AbWDWSkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 14:40:10 -0400
Date: Sun, 23 Apr 2006 14:40:08 -0400
From: Dave Jones <davej@redhat.com>
To: Fabian Zeindl <fabian@xover.htu.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu frequency scaling on celeron laptop
Message-ID: <20060423184008.GB14680@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Fabian Zeindl <fabian@xover.htu.tuwien.ac.at>,
	linux-kernel@vger.kernel.org
References: <444BA1E8.5080001@xover.htu.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444BA1E8.5080001@xover.htu.tuwien.ac.at>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2006 at 05:48:56PM +0200, Fabian Zeindl wrote:
 > Hi
 > 
 >  I have cpu frequency scaling with p4-clockmod in my kernel, and until
 > v2.6.15 I was possible to set governors and custom frequencies at
 > /sys/devices/system/cpu/cpu0/cpufreq/*.
 > When I changed the governor or the frequency scaling_cur_freq
 > represented the change.
 > 
 > With 2.6.16 this isn't possible anymore, I didn't change anything in the
 > kernel .config, just did 'make oldconfig'. There is no 'cpufreq'
 > subdirectory in /sys/devices/system/cpu/cpu0/ anymore.

should be fixed in 2.6.16.9

		Dave

-- 
http://www.codemonkey.org.uk
