Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVASVhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVASVhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVASVhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:37:54 -0500
Received: from natpreptil.rzone.de ([81.169.145.163]:53382 "EHLO
	natpreptil.rzone.de") by vger.kernel.org with ESMTP id S261908AbVASVhv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:37:51 -0500
Date: Wed, 19 Jan 2005 22:38:15 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 0/4] interruptible rwsem and their usage for cpucontrol
Message-ID: <20050119213815.GA8471@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	dhowells@redhat.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following four patches add support for interruptible trying to grab
R/W-semaphores (patches by Nick Piggin), and use (interruptible) rwsems 
to improve the disabling of CPU hotplug operations. The latter was
already discussed earlier on this list[1].

	Dominik

[1] http://marc.theaimsgroup.com/?t=109929898200001&r=1&w=2
