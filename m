Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVBPThe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVBPThe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 14:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVBPThe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 14:37:34 -0500
Received: from zeus.kernel.org ([204.152.189.113]:63875 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261756AbVBPThT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 14:37:19 -0500
Message-ID: <42139B2C.6040709@cs.aau.dk>
Date: Wed, 16 Feb 2005 20:12:44 +0100
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stelian Pop <stelian@popies.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
References: <20050210161809.GK3493@crusoe.alcove-fr> <20050211113636.GI3263@crusoe.alcove-fr>
In-Reply-To: <20050211113636.GI3263@crusoe.alcove-fr>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> Based on feedback from Jean Delvare and Pekka Enberg, here is an
> updated version.
> 
> Changes from the previous version include:
> - do not initialize to 0 a static variable
> - trim to 80 columns
> - do not do spurious void * casts
> - use c99 style struct initialization
> - use simple_strtoul instead of sscanf
> - move documentation to new directory Documentation/acpi
> - name the file 'brightness' instead of 'brt'

Works straight for me (on a Vaio PCG-C1MZX), I can adjust brightness by
feeding the proc/ interface.

I have to try the debug mode.

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.aau.dk
