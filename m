Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270472AbTGaRVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272564AbTGaRVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:21:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36113 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270472AbTGaRVS (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Thu, 31 Jul 2003 13:21:18 -0400
Date: Thu, 31 Jul 2003 19:21:41 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: LKML <linux-kernel@vger.redhat.com>
Subject: Re: 2.6.0-test2, sensors and sysfs
Message-ID: <20030731172141.GA6298@irc.pl>
Mail-Followup-To: Tomasz Torcz <zdzichu@irc.pl>,
	LKML <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Flameeyes wrote:
> I tried either with i2c-viapro and via686a as modules, and built-in in
> kernel. Nothing changes. Also dmesg doesn't output anything.
> I have missed something?

Be aware that via686 (and i2c-isa and probably others) do not work
when compiled into kernel. It must me in a module.

-- 
Tomasz Torcz              "Never underestimate the bandwidth of a station 
zdzicherc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray 
|> Playing: Negative.10.31.02 ...
