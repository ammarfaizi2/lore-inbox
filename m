Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136112AbRAMBUG>; Fri, 12 Jan 2001 20:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136121AbRAMBT4>; Fri, 12 Jan 2001 20:19:56 -0500
Received: from ppp017-pool1a.bham.zebra.net ([209.12.6.80]:128 "HELO
	bliss.penguinpowered.com") by vger.kernel.org with SMTP
	id <S136112AbRAMBTw>; Fri, 12 Jan 2001 20:19:52 -0500
Date: Fri, 12 Jan 2001 19:11:32 -0600
From: "Forever shall I be." <zinx@magenet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4.0-ac8 PS/2 mouse woes
Message-ID: <20010112191132.A548@bliss.zebra.net>
In-Reply-To: <20010112173811.A618@bliss.zebra.net> <E14HE9V-0005ID-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14HE9V-0005ID-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Jan 13, 2001 at 12:02:35AM +0000
X-GPG-Fingerprint: 1A27 513C 33D0 4DB6 BBDD  E891 4E64 FCAA 7455 8D71
X-GPG-Public-Key: http://pgp5.ai.mit.edu:11371/pks/lookup?op=get&search=0x74558D71
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 12:02:35AM +0000, Alan Cox wrote:
> > pc_keyb.c..   I also have the cuecat patch applied, and use it over
> > the PS/2 mouse port, but I don't think it's interfering..  I doubt
> > this will be noticable to people not using the "Resolution" option to
> > speed up the mouse, and mine's rather insane:
> 
> Can you tell me if the problem can be duplicated without the cuecat patch
> applied. It is quite possible the ps/2 mouse patch is buggy

Yes, and I tried out 2.4.0-ac7 too, just for kicks, and it doesn't break
with ac7..

> 
> > Anyway, just letting you know, and very sorry for the lack of
> > information..
> 
> Its most of the info I need. Since I churn through patches fast we can normally
> get a good guess at the culprit.
> 
> Alan
> 

Also, the Oops I got is apparently due to my own code, so I'll be trying
to fumble my way through fixing it :)

-- 
Zinx Verituse                           (See headers for gpg key info)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
