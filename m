Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310159AbSCEThH>; Tue, 5 Mar 2002 14:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310166AbSCETg6>; Tue, 5 Mar 2002 14:36:58 -0500
Received: from ns.suse.de ([213.95.15.193]:40972 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310159AbSCETgy>;
	Tue, 5 Mar 2002 14:36:54 -0500
Date: Tue, 5 Mar 2002 20:36:52 +0100
From: Dave Jones <davej@suse.de>
To: Kamlesh Bans <kbans@corsair.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.5 3c505.c redefine of netdev_ethtool_ioctl and netdev_ioctl
Message-ID: <20020305203652.D4492@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Kamlesh Bans <kbans@corsair.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20020305112638.03394630@pop3.ir.corsair.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4.3.2.7.2.20020305112638.03394630@pop3.ir.corsair.com>; from kbans@corsair.com on Tue, Mar 05, 2002 at 11:32:32AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 11:32:32AM -0800, Kamlesh Bans wrote:
 > 3c505.c:1362: redefinition of `netdev_ethtool_ioctl'
 > 3c505.c:1172: `netdev_ethtool_ioctl' previously defined here
 > 3c505.c:1417: redefinition of `netdev_ioctl'
 > 3c505.c:1227: `netdev_ioctl' previously defined here
 > The module was able to compile with the second occurrences of the two 
 > functions removed.

 That is the correct fix.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
