Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTDPMRn (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 08:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbTDPMRn 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 08:17:43 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60354
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264328AbTDPMRl (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 08:17:41 -0400
Subject: Re: firmware separation filesystem (fwfs)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ranty@debian.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030416005710.GB29682@ranty.ddts.net>
References: <20030416005710.GB29682@ranty.ddts.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050492681.28586.39.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Apr 2003 12:31:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How is this better than simply having your hotplug helper load
the firmware from disk ? Its nice code but you have to ask the
question "why". I don't want the firmware wasting ram, I don't
need the firmware fs wasting ram. I may need to load the right
firmware from a choice of 16 odd types (usb_serial has some
examples there).

Alan

