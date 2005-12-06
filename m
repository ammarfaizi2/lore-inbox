Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVLFRBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVLFRBj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVLFRBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:01:39 -0500
Received: from relay10.CS.McGill.CA ([132.206.3.88]:45325 "EHLO
	relay10.cs.mcgill.ca") by vger.kernel.org with ESMTP
	id S932345AbVLFRBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:01:38 -0500
Message-ID: <4395C3E4.2070703@cs.ubishops.ca>
Date: Tue, 06 Dec 2005 12:01:24 -0500
From: Patrick McLean <pmclean@cs.ubishops.ca>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051026)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] clean-boot.pl version 0.1 - Simple utility to clean
 up /boot and /lib/modules
References: <1133573415.32583.108.camel@localhost.localdomain> <20051203085734.GB22139@alpha.home.local>
In-Reply-To: <20051203085734.GB22139@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> One more reason to put kernels and modules into /boot. On my systems,
> /lib/modules is a symlink to /boot

Not the best idea on distros that use a separate /boot partition that is 
not mounted at boot by default (this is Gentoo's recommended setup).
