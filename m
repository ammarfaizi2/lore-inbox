Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269981AbUJNHJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269981AbUJNHJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 03:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269984AbUJNHJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 03:09:14 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:15233
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S269983AbUJNHJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 03:09:11 -0400
Message-ID: <416E2615.6070402@bio.ifi.lmu.de>
Date: Thu, 14 Oct 2004 09:09:09 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 038 release
References: <20041014003936.GA8810@kroah.com>
In-Reply-To: <20041014003936.GA8810@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"make install" fails with

galois tmp/udev-038# make udevdir=/dev DESTDIR=/root/tmp/test/ EXTRAS="extras/scsi_id" install
make: *** No rule to make target `etc/init.d/udev.debian', needed by `install-initscript'.  Stop.

because there is no udev.debian in etc/init.d/ in the sources.

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
