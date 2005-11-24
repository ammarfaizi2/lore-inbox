Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030613AbVKXH0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030613AbVKXH0O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030615AbVKXH0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:26:14 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:25729 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1030613AbVKXH0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:26:14 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Reboot through the BIOS on newer HP laptops
Date: Thu, 24 Nov 2005 07:26:16 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <20051124052107.GA28070@srcf.ucam.org>
In-Reply-To: <20051124052107.GA28070@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511240726.16669.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 November 2005 05:21, Matthew Garrett wrote:
> Newer HP laptops (nc4200, nc6xxx, nc8xxx) hang on reboot with a standard
> configuration. Passing reboot=b makes them work. This patch adds a DMI
> quirk that defaults them to this mode, and doesn't appear to have any
> adverse affects on older HPs.

Might be better to specify machines that actually have this issue. My NC6000 
does not have any reboot issues with current or prior kernels, and such a 
change risks regressing that.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
