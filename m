Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317260AbSGTAZB>; Fri, 19 Jul 2002 20:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSGTAZA>; Fri, 19 Jul 2002 20:25:00 -0400
Received: from jalon.able.es ([212.97.163.2]:30863 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S317260AbSGTAZA>;
	Fri, 19 Jul 2002 20:25:00 -0400
Date: Sat, 20 Jul 2002 02:27:57 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1
Message-ID: <20020720002757.GC1735@werewolf.able.es>
References: <288F9BF66CD9D5118DF400508B68C4460283E2F5@orsmsx113.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <288F9BF66CD9D5118DF400508B68C4460283E2F5@orsmsx113.jf.intel.com>; from scott.feldman@intel.com on Sat, Jul 20, 2002 at 01:05:55 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.20 "Feldman, Scott" wrote:
>Jamagallon wrote:
>
[...]
>>We have two interfaces:
>>04:04.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
>03:01.0 Ethernet
>>controller: Intel Corp. 82543GC Gigabit Ethernet Controller (rev 02)
>
[...]
>
>There are several factors that may be limiting your throughput on e1000.
>Assuming you have enough CPU umph and bus bandwidth, and your netpipe link
>partner and switch are willing, you should be able to approach wire speed.
>

More info, for it is useful. During a similar run of netpipe, at about 500Mb/s,
switch stats are like this:

------------------------------------------------------------------------------ 
    Switch Overview                      < 2 sec >
------------------------------------------------------------------------------
                                                  Update interval:< 2 sec >
 Port  23145      30792      %Util.      Port    TX/sec     RX/sec   %Util.

  1   |23773     |30928     | 26   |      5   |0         |0         | 0    |

  2   |30923     |23773     | 26   |      6   |0         |0         | 0    |

  3   |0         |0         | 0    |    7-GBIC|n/a       |n/a       | n/a  |

  4   |0         |0         | 0    |    8-GBIC|n/a       |n/a       | n/a  |

Firmware versions:
   Boot PROM version: v2.00.04       
   Firmware version:  v2.00.14       

Ihave seen in Intel web that there is a new firmware numberd 2.00.17, that
corrects some issues. I will try it....

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc2-jam1, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.8mdk)
