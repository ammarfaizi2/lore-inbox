Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVG1Mm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVG1Mm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVG1Mm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:42:56 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:32516 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261431AbVG1Mmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:42:55 -0400
Date: Thu, 28 Jul 2005 14:50:24 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1 compiles unrequested/unconfigured module!
Message-ID: <20050728125024.GA870@aitel.hist.no>
References: <20050715013653.36006990.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050715013653.36006990.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I usually compile without module support.  This time, I turned modules
on in order to compile an external module.

To my surprise, drivers/scsi/qla2xxx/qla2xxx.ko were built even though
no actual modules are selected in my .config, and the source is
not patched at all except the mm1 patch.

Helge Hafting
