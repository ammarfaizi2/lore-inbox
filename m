Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261822AbTCQTHU>; Mon, 17 Mar 2003 14:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261892AbTCQTHT>; Mon, 17 Mar 2003 14:07:19 -0500
Received: from fed.frb.gov ([132.200.32.32]:46580 "HELO fed.frb.gov")
	by vger.kernel.org with SMTP id <S261822AbTCQTHT>;
	Mon, 17 Mar 2003 14:07:19 -0500
Date: Mon, 17 Mar 2003 14:18:00 -0500
From: Seth Lepzelter <spl@frb.gov>
To: linux-kernel@vger.kernel.org
Subject: dhcp autoconfig and MTU size
Message-ID: <20030317191800.GB29488@frb.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Federal Reserve Board of Governors
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to netboot some Xeon machines on a GigE network (and from a 
server) with mtu size 8k.  everything works hunky-dory until the machine 
gets its dhcp autoconguration done, at which point, even though the 
machine responds to a ping, it freezes.  If I set the mtu on the server 
back to 1500, things unfreeze, but GigE doesn't like small frame sizes, so 
that's not really an option.  Am I correct in thinking that the kernel ip 
autoconfig support doesn't set mtu sizes?  

Thanks,
Seth Lepzelter
