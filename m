Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbUAFOJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 09:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbUAFOJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 09:09:49 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:61712 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263571AbUAFOJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 09:09:47 -0500
Date: Tue, 6 Jan 2004 17:09:22 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1-mm[1|2] on Alpha build failure
Message-ID: <20040106170922.A24333@jurassic.park.msu.ru>
References: <20040106044705.GA13288@wang-fu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040106044705.GA13288@wang-fu.org>; from kraken@drunkmonkey.org on Mon, Jan 05, 2004 at 10:47:05PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 10:47:05PM -0600, Nathan Poznick wrote:
> #define cpu_possible_map       cpu_present_map
> seems to have caused a problem, since cpu_present_map doesn't appear to
> be declared anywhere.

It should be "cpu_present_mask", I'd guess.

Ivan.
