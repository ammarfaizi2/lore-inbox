Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUAVL0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 06:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUAVL0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 06:26:44 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:28140 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S266237AbUAVL0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 06:26:43 -0500
Date: Thu, 22 Jan 2004 03:26:28 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MD Raid compatability between 2.4/2.6
Message-ID: <20040122112628.GR23765@srv-lnx2600.matchmail.com>
Mail-Followup-To: Jan De Luyck <lkml@kcore.org>,
	linux-kernel@vger.kernel.org
References: <200401221059.39223.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401221059.39223.lkml@kcore.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 10:59:39AM +0100, Jan De Luyck wrote:
> Hello List,
> 
> Just wondering: is an md mirror setup under 2.6 compatible with 2.4? 
> Basically: I want to downgrade a machine currently running 2.6.0 to 2.4.24, 
> but it's setup with a mirror raid that I don't really want to bother setting 
> up again.

Yes, as long as you're not trying the new raid6 code (very experemental
right now).
