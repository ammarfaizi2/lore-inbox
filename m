Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbULMXLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbULMXLm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 18:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbULMXLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 18:11:42 -0500
Received: from main.gmane.org ([80.91.229.2]:54152 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261237AbULMXL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 18:11:28 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Juergen Botz <jurgen@botz.org>
Subject: Thinkpad T42, keyboard sometimes hosed when waking from sleep
Date: Mon, 13 Dec 2004 14:56:34 -0800
Message-ID: <cpl6n2$ivd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: w002.z065106067.sjc-ca.dsl.cnc.net
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a new IBM Thinkpad T42, FC3 with all updates, stock
2.6.9-1.681_FC3 kernel + iwp2200 driver (0.13).  Everyone once
in a while when I wake from ACPI S3 sleep my keyboard is hosed...
the first key I press starts rapidly auto-repeating, which can't
be stopped, and pressing any key produces either no visible
action or some other character (not the one normally on that
key) which also auto repeats madly.

It doesn't always happen, only maybe 10% of the time I come
out of S3.  I can't switch to different vt since ctrl-alt-fN
don't work, and since I am rarely on a text console I have
no idea whether it would happen there.  Putting the machine
back to sleep and re-waking doesn't fix it, so my only option
has been to reboot via the 'Actions' menu (mouse is ok through
all this.)

Others have also reported this happening with APM, so it
doesn't seem to be an ACPI bug per se.

Any ideas?

:j

