Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130782AbRBAQNs>; Thu, 1 Feb 2001 11:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130457AbRBAQNj>; Thu, 1 Feb 2001 11:13:39 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:35096 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S130735AbRBAQNV>; Thu, 1 Feb 2001 11:13:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14969.35608.472226.83936@somanetworks.com>
Date: Thu, 1 Feb 2001 11:13:12 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: John Jasen <jjasen@datafoundation.com>
Cc: William Knop <w_knop@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Modules and DevFS
In-Reply-To: <Pine.LNX.4.30.0102011021520.31149-100000@flash.datafoundation.com>
In-Reply-To: <F204tAEHLB8TrBHxvZ900001de6@hotmail.com>
	<Pine.LNX.4.30.0102011021520.31149-100000@flash.datafoundation.com>
X-Mailer: VM 6.75 under 21.2  (beta40) "Persephone" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "JJ" == John Jasen <jjasen@datafoundation.com> writes:

 JJ> On Thu, 1 Feb 2001, William Knop wrote:
 >> >One thing that I've noticed with devfs is that all the old-style
 >> >names are symlinks.
 >>
 >> Hmm... I have no symlinks until the module loads. Therefore X sees
 >> no /dev/input/mouse, doesn't ask the kernel for it, the kernel
 >> doesn't load the module, and DevFS doesn't add the /dev
 >> entry. There's got to be an easy way around this. Perhaps it has
 >> already been implimented, but I haven't been able to get anything
 >> to work well (manual loading for me).

 JJ> change your XF86Config file to point to /dev/psaux

Or /dev/input/mice if you use a USB thang.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
