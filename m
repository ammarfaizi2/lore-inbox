Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264729AbTFEQJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264730AbTFEQJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:09:59 -0400
Received: from aneto.able.es ([212.97.163.22]:22979 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264729AbTFEQJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:09:59 -0400
Date: Thu, 5 Jun 2003 18:23:28 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE CDRW and ide-scsi fun?
Message-ID: <20030605162328.GA3351@werewolf.able.es>
References: <20030605160440.GE8594@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030605160440.GE8594@rdlg.net>; from Robert.L.Harris@rdlg.net on Thu, Jun 05, 2003 at 18:04:40 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.05, Robert L. Harris wrote:
> 
> 
> I have a DVD-CDRW:
> 
> 'SONY    ' 'DVD RW DRU-510A ' '1.0a' Removable CD-ROM
> 
> If I compile ide-cd and ide-scsi into the kernel I can see the drives
> but cdrecord doesn't recognize them, even if I specify the device (2,0,0).
> If I compile either one in and modularize the other I get the same
> thing.  If I modularize both and then load them:
> 
> modprobe ide-scsi
> modprobe ide-cd
> 
> 

Obvious question, have you tried to boot with 'hdc=ide-scsi' ?
(for both builtin, ide has preference...)

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc7-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
