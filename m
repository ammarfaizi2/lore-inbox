Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbTAEAHT>; Sat, 4 Jan 2003 19:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbTAEAHT>; Sat, 4 Jan 2003 19:07:19 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:60810 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S261963AbTAEAHS>;
	Sat, 4 Jan 2003 19:07:18 -0500
Date: Sun, 5 Jan 2003 01:15:50 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE-SCSI grabs too many drives
Message-ID: <20030105001550.GA17583@werewolf.able.es>
References: <3E169992.8080200@asjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3E169992.8080200@asjohnson.com>; from andy@asjohnson.com on Sat, Jan 04, 2003 at 09:21:38 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.04 Andrew S. Johnson wrote:
> I have append="hdc=ide-scsi" in my lilo.conf file,
> but when I modprobe ide-scsi, it grabs both the
> CD-RW and the DVD-ROM:
> 

I think the correct param is "hdc=scsi", with incorrect param and no
ide-cd loaded, probably ide-scsi grabs anything it can...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
