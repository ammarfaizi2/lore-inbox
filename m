Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUEIS4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUEIS4R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 14:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUEIS4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 14:56:16 -0400
Received: from ns.clanhk.org ([69.93.101.154]:62417 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S264373AbUEIS4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 14:56:13 -0400
Message-ID: <409E7E74.9040702@clanhk.org>
Date: Sun, 09 May 2004 13:54:44 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Distributions vs kernel development
References: <20040507085312.3247d70d@dell_ss3.pdx.osdl.net> <409BC735.2060308@techsource.com>
In-Reply-To: <409BC735.2060308@techsource.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

> Stephen Hemminger wrote:
>
>> After having being burned twice: first by Mandrake and supermount, 
>> and second
>> by SuSe and reiserfs attributes; are any of the distributions 
>> committed to
>> making sure that their distribution will run the standard kernel? 
>> (ie. 2.6.X from
>> kernel.org). 
>
>
> I use Gentoo for this.

As do I, I've never had a problem with a Vanilla kernel or one of 
Gentoo's maintained kernels.  Gentoo actually supports the 2.6 kernel, 
at least on AMD64 hardware that's all they support.  Though the vanilla 
kernels -do- work flawlessly, I still prefer the Gentoo patched kernels:

 >>> Unpacking linux-2.6.5.tar.bz2 to 
/var/tmp/portage/gentoo-dev-sources-2.6.5-r1/work
 * genpatches-2.6-5.29-base.tar.bz2 unpacked
 * genpatches-2.6-5.29-extras.tar.bz2 unpacked
 * Applying 
gentoo-dev-sources-2.6.5.CAN-2004-0109.patch...                                                    
[ ok ]
 * Applying 
1105_CAN-2004-0075-usb-vicam.patch...                                                              
[ ok ]
 * Applying 
1305_x86_64-2.6.5-rc3.patch...                                                                     
[ ok ]
 * Applying 
1310_k8_cardbus_io.patch...                                                                        
[ ok ]
 * Applying 
1315_alpha-sysctl-uac.patch...                                                                     
[ ok ]
 * Applying 
1905_bluetooth-oops.patch...                                                                       
[ ok ]
 * Applying 
2110_bcm5700_broadcom_gigabit_drvr_11272003.patch...                                               
[ ok ]
 * Applying 
2115_fa311-mac-address-fix.patch...                                                                
[ ok ]
 * Applying 
2320_adaptec_dpt_i2o.patch...                                                                      
[ ok ]
 * Applying 
2325_3ware-cmds_per_lun.patch...                                                                   
[ ok ]
 * Applying 
2705_powernow-k8-acpi.patch...                                                                     
[ ok ]
 * Applying 
3110_low-latency-cond_resched.patch...                                                             
[ ok ]
 * Applying 
3305_am9-2.6.4.patch...                                                                            
[ ok ]
 * Applying 
3310_cfq-4.patch...                                                                                
[ ok ]
 * Applying 
4105_lirc_infrared-2.6.5-rc2.patch...                                                              
[ ok ]
 * Applying 
4505_bootsplash-3.1.4-2.6.5-rc2.patch...                                                           
[ ok ]
 * Applying 
4705_squashfs-1.3r3.patch...                                                                       
[ ok ]
 * Applying 
4710_lufs-0.9.7-2.6.0-test9.patch...                                                               
[ ok ]
 * Applying 
4715_supermount-2.0.4-2.6.5_rc1.patch...                                                           
[ ok ]
 * Applying 
4720_gcloop-2.6-20040330.patch...                                                                  
[ ok ]
 * Applying 
4905_speakup_accessibility.patch...                                                                
[ ok ]
 >>> Source unpacked.

The k8/x86_64, broadcom, and bootsplash patches in particular make me 
happy.  They tend to stay within one or two minor kernel revisions of 
the current branch.  I've had production 2.6 servers for months.

-ryan
