Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289219AbSANMoi>; Mon, 14 Jan 2002 07:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289220AbSANMo2>; Mon, 14 Jan 2002 07:44:28 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:42721 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S289219AbSANMoS>; Mon, 14 Jan 2002 07:44:18 -0500
Date: Mon, 14 Jan 2002 12:45:41 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: mingo@redhat.com
Subject: slowdown with new scheduler.
Message-ID: <20020114124541.A32412@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,
 After adding H7 to 2.4.18pre3, I noticed that kernel compiles
on one of my test boxes got much slower.
Uniprocessor system (Cyrix 3) building a 2.4.18pre3 tree,
with the same .config, and a distclean before starting the compile.

2.4.18pre3        13.38s                       
2.4.18pre+H7      17.53s

I see similar slowdown when running H7 on 2.5 on this box.

regards,
Dave.

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
