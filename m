Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWDSV6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWDSV6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWDSV6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:58:06 -0400
Received: from gherkin.frus.com ([192.158.254.49]:27912 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S1751265AbWDSV6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:58:05 -0400
Subject: Re: class_device_add error in SCSI with 2.6.17-rc2-g52824b6b
In-Reply-To: <20060419213129.GA9148@localhost> "from Mathieu Chouquet-Stringer
 at Apr 19, 2006 11:31:29 pm"
To: Mathieu Chouquet-Stringer <mchouque@free.fr>
Date: Wed, 19 Apr 2006 16:58:03 -0500 (CDT)
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20060419215803.6DE5BDBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Chouquet-Stringer wrote:
> While booting 2.6.17-rc2-g52824b6b on an alpha (a 164LX clone), I get
> the following error messages for every sd devices that get registered:
> 
> sd 0:0:0:0: Attached scsi disk sda
> kobject_add failed for 0:0: with -EEXIST, don't try to register things with the same name in the same directory.

Similar error previously reported by me for 2.6.17-rc1, except sda got
added fine: error occurred when attempting to add/register sdb. 
Thankfully, you were able to append a trace...

I'll be trying the just-released 2.6.17-rc2 this evening.  Report to
follow, and if there's a problem, I'll attempt to provide the trace
(will have to be transcribed by hand, as system won't come up far
enough for syslog to capture anything).

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
