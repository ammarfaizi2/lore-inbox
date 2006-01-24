Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWAXXAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWAXXAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWAXXAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:00:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:51119 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750811AbWAXXAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:00:47 -0500
Date: Tue, 24 Jan 2006 23:59:19 +0100
From: Stefan Seyfried <seife@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org
Subject: e100 oops on resume
Message-ID: <20060124225919.GC12566@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: SUSE LINUX 10.0.42 (i586) Beta2, Kernel 2.6.16-rc1-git3-3-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
since 2.6.16rc1-git3, e100 dies on resume (regardless if from disk, ram or
runtime powermanagement). Unfortunately i only have a bad photo of
the oops right now, it is available from
https://bugzilla.novell.com/attachment.cgi?id=64761&action=view
I have reproduced this on a second e100 machine and can get a serial
console log from this machine tomorrow if needed.
It did resume fine with 2.6.15-git12
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
