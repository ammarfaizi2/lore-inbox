Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132432AbRA2P1V>; Mon, 29 Jan 2001 10:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132549AbRA2P1L>; Mon, 29 Jan 2001 10:27:11 -0500
Received: from [213.95.15.193] ([213.95.15.193]:40975 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132432AbRA2P04>;
	Mon, 29 Jan 2001 10:26:56 -0500
Date: Mon, 29 Jan 2001 13:30:16 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: James Sutherland <jas88@cam.ac.uk>,
        Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
Message-ID: <20010129133016.A28458@gruyere.muc.suse.de>
In-Reply-To: <951am4$gbf$1@ncc1701.cistron.net> <Pine.SOL.4.21.0101281642180.16734-100000@green.csi.cam.ac.uk> <14965.7321.926528.391631@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14965.7321.926528.391631@pizda.ninka.net>; from davem@redhat.com on Sun, Jan 28, 2001 at 11:32:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 11:32:41PM -0800, David S. Miller wrote:
> 
> James Sutherland writes:
>  > Except you can detect and deal with these "PMTU black holes". Just as you
>  > should detect and deal with ECN black holes. Maybe an ideal Internet
>  > wouldn't have them, but this one does. If you can find an ideal Internet,
>  > go code for it: until then, stick with the real one. It's all we've got.
> 
> Guess what, Linux works not around PMTU black holes either for the
> same exact reason we will not work around ECN.

Actually PMTU black hole detection is very hard. I tried to implement it, but
failed to make it not do bad things occasionally. 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
