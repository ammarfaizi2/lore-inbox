Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129220AbQKPQpW>; Thu, 16 Nov 2000 11:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129222AbQKPQpO>; Thu, 16 Nov 2000 11:45:14 -0500
Received: from mlx3.unm.edu ([129.24.8.189]:29216 "HELO mlx3.unm.edu")
	by vger.kernel.org with SMTP id <S129220AbQKPQpE>;
	Thu, 16 Nov 2000 11:45:04 -0500
Date: Thu, 16 Nov 2000 09:15:00 -0700 (MST)
From: Todd <todd@unm.edu>
To: linux-kernel@vger.kernel.org
Subject: hw or other prob?
Message-ID: <Pine.A41.4.21.0011160908240.39700-100000@aix04.unm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

folx,

on 2.4.0-test6 i got a bunch of the following log messages and then the
console went dead (well, power-saving monitor and no amount of activity
on the keyboard or mouse made it wake up), but the machine still responded
to pings (could not connect w/ telnet or ssh or rlogin). 

does this look like a genuine hw problem or should i upgrade to a newer
2.4.0 test kernel?  i'm happy to do any troubleshooting suggested.

log messages (lots and lots of them.  they all look just like this):

Nov 12 06:43:30 zapata kernel: APIC error interrupt on CPU#0, should never
happen. 
Nov 12 06:43:30 zapata kernel: ... APIC ESR0: 00000002 
Nov 12 06:43:30 zapata kernel: ... APIC ESR1: 00000002 
Nov 12 06:43:30 zapata kernel: ... bit 1: APIC Receive CS Error (hw
problem). 
Nov 12 06:43:30 zapata kernel: APIC error interrupt on CPU#1, should never
happen. 
Nov 12 06:43:30 zapata kernel: ... APIC ESR0: 00000002 
Nov 12 06:43:30 zapata kernel: ... APIC ESR1: 00000002 
Nov 12 06:43:30 zapata kernel: ... bit 1: APIC Receive CS Error (hw
problem). 
Nov 12 07:43:18 zapata kernel: APIC error interrupt on CPU#1, should never
happen. 
Nov 12 07:43:18 zapata kernel: ... APIC ESR0: 00000002 
Nov 12 07:43:18 zapata kernel: ... APIC ESR1: 00000002 
Nov 12 07:43:18 zapata kernel: ... bit 1: APIC Receive CS Error (hw
problem). 
Nov 12 07:43:18 zapata kernel: APIC error interrupt on CPU#0, should never
happen. 

machine is smp pIII450 running on a intel N440bx mb.  main disk is ide,
but i'm using sym53c8xx to access two scsi disks in a logical volume.

thanks,


todd underwood
todd@unm.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
