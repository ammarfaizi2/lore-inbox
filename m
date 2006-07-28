Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751931AbWG1AK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbWG1AK6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 20:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbWG1AK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 20:10:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:5241 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751931AbWG1AK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 20:10:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JhWKdL9vD1O1NL43P6G2nOeAPJZOJvgEL2KXBYnZInFyUDFsZHwOmMn6sHA8K8Zu41ifuXynVLHTtBesu+yhXcHn69NBeyr43bgYhNJ8Trh3tTKjJm0636yjWVyasxDg2G80ql09GFCT6P4EV8K2EpkM+tvpYG5gGcnLOi2fFXQ=
Message-ID: <41840b750607271710r6b3cfffdjc5ca60d0f1618284@mail.gmail.com>
Date: Fri, 28 Jul 2006 03:10:56 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: Generic battery interface
Cc: "Pavel Machek" <pavel@suse.cz>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
       vojtech@suse.cz, "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB601168A85@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB601168A85@hdsmsx411.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, Brown, Len <len.brown@intel.com> wrote:
> I'm not religious about /dev vs. /sys.

I would greatly prefer a sysfs interface.
Having a clean, textual sysfs API that's easily accessed from shell
has been extremely conductive for the development of the tp_smapi
driver -- users can easily test and script the driver without extra
programming and userspace components. Since tp_smapi is (AFAIK) the
most feature-rich battery driver we now have, this is some to
consider.

(If you're not convinced yet, let me say one word: udev.)

  Shem
