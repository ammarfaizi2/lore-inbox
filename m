Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWHXNJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWHXNJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWHXNJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:09:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52203 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751340AbWHXNJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:09:58 -0400
Date: Thu, 24 Aug 2006 15:09:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: CIJOML <cijoml@volny.cz>
Cc: bluez-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Microsoft BT mouse's optical sensor switches off???
Message-ID: <20060824130946.GB7055@elf.ucw.cz>
References: <200608240859.11195.cijoml@volny.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608240859.11195.cijoml@volny.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2006-08-24 08:59:11, CIJOML wrote:
> Hi,
> 
> I upgraded my debian linux to newest testing version:
> 
> notas:/usr/src/linux-2.6.18-rc4# dpkg -l|grep -i bluez
> ii  bluez-hcidump                    1.31-1                      Analyses 
> Bluetooth HCI packets
> ii  bluez-utils                      3.1-3.1                     Bluetooth 
> tools and daemons
> ii  libbluetooth1                    2.25-2                      Library to 
> use the BlueZ Linux Bluetooth stack
> ii  libbluetooth2                    3.1-1                       Library to 
> use the BlueZ Linux Bluetooth stack
> 
> and linux kernel to 2.6.18-rc4 to have also latest BlueZ kernel.
> 
> Everything works fine, except mouse?!
> 
> Mouse works, but it sensor getts off in a very short time. I have to click 
> 2times any button on it to start it again to move cursor?!
> 
> This really p*ss me off.
> 
> Where can I switch off this "feature"??

Find where it started happening with git bisect, then file proper
bugzilla report, I'd say...
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
