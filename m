Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVLLLWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVLLLWp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 06:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVLLLWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 06:22:45 -0500
Received: from cantor.suse.de ([195.135.220.2]:64717 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751236AbVLLLWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 06:22:44 -0500
Date: Mon, 12 Dec 2005 12:22:05 +0100
From: Stefan Seyfried <seife@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: vojtech@suse.cz, dtor_core@ameritech.net, luming.yu@intel.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, len.brown@intel.com,
       bero@arklinux.org
Subject: Re: [git pull 02/14] Add Wistron driver
Message-ID: <20051212112205.GA23881@suse.de>
References: <20051211224059.GA28388@midnight.suse.cz> <20051212001315.0e2c64f1.akpm@osdl.org> <20051212091427.GB21522@suse.de> <20051212013844.59a1f76e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051212013844.59a1f76e.akpm@osdl.org>
X-Operating-System: SUSE LINUX 10.0 (i586), Kernel 2.6.13-15.7-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 01:38:44AM -0800, Andrew Morton wrote:
> Stefan Seyfried <seife@suse.de> wrote:
> > No. The ACPI Mafia^H^H^Hintainers :-) no longer accept any hotkey drivers
> > and IIUC it will be reimplemented in a generic driver. This driver
> > then should pipe the hotkey events to the input subsystem.
> 
> hm.  It seems a fairly bad idea to remove functionality before that
> functionality has been implemented by the other means and has been rolled
> out by distros for some time.

pcc_acpi never was in the acpi tree or in mainline AFAIK.
But it is nevertheless an example that it is not too hard to route hotkey
events through the input subsystem :-)
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
