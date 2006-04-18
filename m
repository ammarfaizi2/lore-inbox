Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWDRAuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWDRAuN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 20:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWDRAuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 20:50:13 -0400
Received: from smtpout.mac.com ([17.250.248.174]:58314 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932091AbWDRAuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 20:50:11 -0400
In-Reply-To: <200604171741.k3HHfx5G006341@turing-police.cc.vt.edu>
References: <85e0e3140604170625k112680f8qd4ef96f7d3d3ea98@mail.gmail.com> <200604171741.k3HHfx5G006341@turing-police.cc.vt.edu>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2FAC7488-8B72-45DF-9335-E6C6C25CFDF2@mac.com>
Cc: Niklaus <niklaus@gmail.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Boot CDrom from grub
Date: Mon, 17 Apr 2006 20:50:06 -0400
To: Valdis.Kletnieks@vt.edu
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 17, 2006, at 13:41:59, Valdis.Kletnieks@vt.edu wrote:
> If you have enough physical access to boot the machine from a CD,  
> you have enough access to work around the BIOS password problem.   
> In almost all cases, cracking the case and changing/removing a  
> jumper on the motherboard will bypass/reset the password, and  
> Google will tell you which jumper it is.

This is true; with the exception of some incredibly poorly designed  
HP desktops I once had the misfortune of administrating.  For some  
insane reason HP decided to store the BIOS password in flash RAM and  
declined to provide any method for resetting it.  In the manual, they  
specified "If you for any reason forget your BIOS password, please  
ship the computer to a certified service station to have it reset".   
The only other known way is to unsolder the surface-mount flash chip  
from the MB and place it in a flash writer.

We've since managed to lose the passwords for a few of those  
desktops; is there any way to get linux to overwrite the flash RAM  
soldered to the motherboard?

Cheers,
Kyle Moffett

