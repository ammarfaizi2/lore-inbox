Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269580AbUIZRFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269580AbUIZRFr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 13:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269581AbUIZRFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 13:05:47 -0400
Received: from dhcp-129-114-141-243.i2.utexas.edu ([129.114.141.243]:28545
	"EHLO debian") by vger.kernel.org with ESMTP id S269580AbUIZRFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 13:05:43 -0400
Date: Sun, 26 Sep 2004 19:05:11 +0200
From: Lukas Hejtmanek <xhejtman@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>
Subject: 2.6.9-rc2-mm2 - p4mod_clock + suspend troubles (update)
Message-ID: <20040926170511.GA2217@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

it seems to be mtrr issue. After resume Xserver reports that reg03 is not used.
This register is write-combining to AGP aperture. And any drawing is slow.

With vanilla it is ok.

-- 
Luká¹ Hejtmánek
