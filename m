Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbTJOR0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263727AbTJOR0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:26:42 -0400
Received: from kung-2.eecs.harvard.edu ([140.247.60.197]:9872 "EHLO bluesky")
	by vger.kernel.org with ESMTP id S263709AbTJOR0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:26:40 -0400
Date: Wed, 15 Oct 2003 10:26:43 -0700
From: Adam Kessel <adam@bostoncoop.net>
To: linux-kernel@vger.kernel.org
Subject: Re: vaio doesn't poweroff with 2.4.22
Message-ID: <20031015172643.GA5431@joehill.bostoncoop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are apparently several HP OmniBook models that don't poweroff with
ACPI under 2.4.22 as well.  

HP hasn't released a new BIOS for the OmniBook 500 since pre-2001, so I
have to boot with acpi=force.

Up through 2.4.22rc2 the OB500 shut down fine with ACPI.  Somewhere in
between 2.4.22rc2 and 2.4.22 ACPI shut down stopped working. With
2.4.23-pre7, it still doesn't work.  

Reboot, however, works fine.

Does anyone know what change occurred between 2.4.22rc2 and 2.4.22 that
would have caused the power down to stop working?
-- 
Adam Kessel
http://bostoncoop.net/adam
