Return-Path: <linux-kernel-owner+w=401wt.eu-S1752314AbXACAkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbXACAkm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbXACAkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:40:42 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:60814 "EHLO ns2.lanforge.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314AbXACAkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:40:41 -0500
X-Greylist: delayed 2115 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 19:40:41 EST
Message-ID: <459AF345.3080508@candelatech.com>
Date: Tue, 02 Jan 2007 16:05:25 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: FWA7304 VIA C3 system work-around for power-off bug.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Older versions of the iBase FWA7304 BIOS have a bug that causes the
system to use way too much power when you run 'init 0', causing
the power brick to burn out after about 3 hours.

The fix for this is to get an updated BIOS from the manufacturer:
IB798F-T2-CP1A-1229

The problem still happens if you enable ACPI, but at least it seems
fixed if you disable ACPI.

Hope this helps someone!

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

