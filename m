Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263987AbTEFQzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263975AbTEFQzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:55:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54289 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263987AbTEFQzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:55:18 -0400
Date: Tue, 6 May 2003 18:07:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@transvirtual.com>
Subject: 2.5.69: Missing logo?
Message-ID: <20030506180707.B15174@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	James Simmons <jsimmons@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I seem to have a penguin missing in action, somewhere between 2.5.68 and
2.5.69.  Has anyone else lost a penguin under similar circumstances?

$ grep LOGO linux-sa1100/.config
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

Other than the missing logo, the fb display looks as it did under 2.5.68.

assabet$ fbset

mode "320x240-60"
        geometry 320 240 320 240 16
        timings 171521 61 9 3 0 5 1
        accel false
        rgba 5/11,6/5,5/0,0/0
endmode

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

