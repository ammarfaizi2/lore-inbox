Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVC3OQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVC3OQA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 09:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVC3OQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 09:16:00 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:21513 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261905AbVC3OPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 09:15:53 -0500
Date: Wed, 30 Mar 2005 16:15:50 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050330141550.GA71637@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <be1ed86fc663c1a441ab51ea3d6fd4fe@mac.com> <MDEHLPKNGKAHNMBLJOLKAEIHCMAB.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEIHCMAB.davids@webmaster.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 11:00:30AM -0800, David Schwartz wrote:
> 	Since the GPL permits their removal, removing them cannot be circumventing
> the GPL. Since the GPL is the only license and the license permits you to
> remove them, they cannot be a license enforcement mechanism. How can you
> enforce a license that permits unrestricted functional modification?

You misunderstand totally the EXPORT_GPL system.  It does not mean
"this is a technological system to prevent you to use it with non-gpl
compatible code".  It means "The author of that code consider that
using this function makes your code so linux-specific that it must be
a derivative work of the code implementing the function, so if you use
it from non gpl-compatible code you'll be sued.  And since he's nice,
he uses a technical method to prevent you from doing such a copyright
violation by mistake.".

See the subtle difference?  EXPORT_GPL is here to _help_ proprietary
driver authors.  Your lawyers should _love_ it and skin you alive if
you try to get around it.

  OG.

