Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbWJKMyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbWJKMyW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWJKMyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:54:22 -0400
Received: from hu-out-0506.google.com ([72.14.214.236]:53831 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161048AbWJKMyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:54:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=KvlD+ysgc3DdIRimYYQnbjENRUq34iENOno82YNQC1uyoF0+ftIuczOcIcI4DheNs8yiXxriZV58hB+ZO5Un/PezCdrkczxseUx5rUBagXvDraC2YMxZgfB7EpuJIrc4888gMwPjEdVMBU6/JbgzHIDydAzjuGrNSrIUTG4HvQs=
Subject: Re: [PATCH] Add support for the generic backlight device to the
	IBM ACPI driver
From: Richard Hughes <hughsient@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       len.brown@intel.com
In-Reply-To: <20061011113042.GA4725@ucw.cz>
References: <20061009113235.GA4444@homac.suse.de>
	 <20061011113042.GA4725@ucw.cz>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 13:54:17 +0100
Message-Id: <1160571257.4936.7.camel@hughsie-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 11:30 +0000, Pavel Machek wrote:
> Looks okay to me. It would be nice to get this in, so that we teach
> people to use generic interface, and so that we can remove crappy
> interfaces in future...

What about needing a module parameter "enable-old-interface" so by
default be only support the new interface but can support the legacy one
if the user is running old userspace stuff? Insane?

Richard.


