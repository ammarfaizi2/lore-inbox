Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUITRER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUITRER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 13:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUITRER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 13:04:17 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:20479 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S266741AbUITRBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 13:01:40 -0400
Date: Mon, 20 Sep 2004 19:02:16 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add on-demand cpu-freq governor as default option
Message-ID: <20040920170216.GA7952@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <cone.1095649950.909900.10443.502@pc.kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cone.1095649950.909900.10443.502@pc.kolivas.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry, but this can't be done at the moment. The default cpufreq
governor needs to be one which can't fail to start up. And on-demand has
quite strict requirements on when it allows to be started and when it
doesn't.

	Dominik
