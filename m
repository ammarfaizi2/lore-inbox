Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281511AbRKHLGc>; Thu, 8 Nov 2001 06:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281515AbRKHLGW>; Thu, 8 Nov 2001 06:06:22 -0500
Received: from t2.redhat.com ([199.183.24.243]:40952 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S281511AbRKHLGP>; Thu, 8 Nov 2001 06:06:15 -0500
Message-ID: <3BEA6725.739463C2@redhat.com>
Date: Thu, 08 Nov 2001 11:06:13 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-7smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Zvi Har'El" <rl@math.technion.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
In-Reply-To: <E161aYo-0000ch-00@fenrus.demon.nl> <Pine.GSO.4.33.0111080903360.28492-100000@leeor.math.technion.ac.il>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zvi Har'El wrote:
> 
> Hi all,
> 
> Initrd did it! I was not using initrd. I generated the relevant initrd.img and
> added the line to my grub.conf configuration, and the problem is solved.
> System crashes are now easily recovered.
> 
> The only mystery is, why RedHat has ext3fs compiled as a module?

The basic idea is "everything which can be a module will be a module", 
even scsi is a module. And if you use grub, it's 100% transparent as the
initrd
will be automatically added to the grub config when you install the RH
kernel rpm;
even if you use lilo the initrd is supposed to be made for you
automatically.

Greetings,
    Arjan van de Ven
