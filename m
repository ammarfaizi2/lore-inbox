Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315352AbSDWVh6>; Tue, 23 Apr 2002 17:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315343AbSDWVh5>; Tue, 23 Apr 2002 17:37:57 -0400
Received: from jalon.able.es ([212.97.163.2]:64495 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315352AbSDWVh5>;
	Tue, 23 Apr 2002 17:37:57 -0400
Date: Tue, 23 Apr 2002 23:37:50 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: m.knoblauch@TeraPort.de
Cc: Stephen Lord <lord@sgi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: XFS in the main kernel
Message-ID: <20020423213750.GA1704@werewolf.able.es>
In-Reply-To: <3CC56355.E5086E46@TeraPort.de> <3CC56FE9.1080303@sgi.com> <3CC581F5.2FBEA0C1@TeraPort.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.23 Martin Knoblauch wrote:
>Stephen Lord wrote:
>> 
>> Martin Knoblauch wrote:
>> 
>> >
>> > definitely. Unless XFS is in the mainline kernel (marked as
>> >experimantal if necessary) it will not get good exposure.
>> >
[...]
>
> From a mainline point of view XFS on Linux will only be successfull if
>it is "in the kernel". Fully maintained and "Linus approved". I am not
>sure when SGI started the port (could even go back to the time when I
>worked for them, late 1997). Definitely quite some time. By now it
>should be in the kernel. Maybe marked "experimental". As I see it now
>EXT3, ReiserFS and maybe JFS are just eating the XFS lunch away.
>
> In any case, the Vanderbilt comment is right on.
>

If XFS is so good (i do not doubt it), I see some issues (plz correct me
if I'm wrong...):

- XFS needs substantial changes in the VFS layer to work
- This changes are good (or make xfs so good)
- *THE THING* to do is to integrate this changes in mainline tree VFS,
  so XFS will stop duplicating half the kernel code.

Why those features are not merged ? Incompatibilities ? Licensing ?
Religious wars about some way of doing things ?

Plz, if SGI splits XFS in small chunks and starts feeding linus with
changes in the VFS, what will happen ? Why that doesn't happen ?

Just some ideas...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam6 #2 SMP mar abr 23 16:56:56 CEST 2002 i686
