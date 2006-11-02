Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752648AbWKBIjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbWKBIjp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbWKBIjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:39:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:17141 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752648AbWKBIjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 03:39:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=QDikx8pRHlsB9MzbLYD8VZrekI+XnMe1XLGnSA5cj/qcvsS3D9wvgNmEZIllPjJGKzfXP5dOCUrptH1MQW4U1m/+5P0PJLl8XcV6oq9cfC8dxufEjYgi1+4nUGKAqhlc3i2HArWTLaybOb8vR0ht2h2zPHt/b7NTnpZAuGO9vfM=
Subject: Re: [PATCH v2] Re: Battery class driver.
From: Richard Hughes <hughsient@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: multinymous@gmail.com, xavier.bestel@free.fr, davidz@redhat.com,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <znLIYxER.1162453921.3011900.khali@localhost>
References: <znLIYxER.1162453921.3011900.khali@localhost>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 08:39:40 +0000
Message-Id: <1162456780.4983.3.camel@hughsie-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 08:52 +0100, Jean Delvare wrote:
> You just need to know the voltage of the battery, what else?

This isn't as easy as you think. The number of broken BIOS's that have
the current, last full or design either as 0xFFFF, 0xFFFFFF, 0, 1mV, or
10000mV rather than the present (correct) value is a big problem.

We've got quite a bit of code in HAL to try and sort out all the quirks,
although it only works most of the time due to extreme hardware
brokenness.

Richard.


