Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSE3Kfj>; Thu, 30 May 2002 06:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSE3Kfi>; Thu, 30 May 2002 06:35:38 -0400
Received: from jalon.able.es ([212.97.163.2]:59283 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316569AbSE3Kfh>;
	Thu, 30 May 2002 06:35:37 -0400
Date: Thu, 30 May 2002 12:35:32 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Michael Dunsky <michael.dunsky@p4all.de>, linux-kernel@vger.kernel.org,
        Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: Strange code in ide_cdrom_register
Message-ID: <20020530103532.GA17794@werewolf.able.es>
In-Reply-To: <15605.34861.599803.405864@wombat.chubb.wattle.id.au> <3CF5D424.2060500@p4all.de> <15605.60268.673419.701625@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.30 Peter Chubb wrote:
>>>>>> "Michael" == Michael Dunsky <michael.dunsky@p4all.de> writes:
>
>But, *(int*)&devinfo->speed is an int no matter what type
>devinfo->speed has.  So if for some reason, you decide to change the

Perhaps this comes from a time when devinfo->speed was a void*.
I remember changes of that kind on the IDE layer commented in the list.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre9-jam1 #1 SMP mié may 29 02:20:48 CEST 2002 i686
