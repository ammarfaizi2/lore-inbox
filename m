Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266067AbUFDXjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266067AbUFDXjY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUFDXjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:39:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52121 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266067AbUFDXjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:39:18 -0400
Message-ID: <40C107D2.9030301@pobox.com>
Date: Fri, 04 Jun 2004 19:37:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: viro@parcelfarce.linux.theplanet.co.uk, perex@suse.cz, torvalds@osdl.org
Subject: Re: [RFC] ASLA design, depth of code review and lack thereof
References: <20040604230819.GR12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040604230819.GR12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While we're bitching about ALSA, can we please kill the 
subsystem-specific malloc and "magic cast" wrappers?

This debug machinery is better done elsewhere...


