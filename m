Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265345AbRFVGMy>; Fri, 22 Jun 2001 02:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265346AbRFVGMf>; Fri, 22 Jun 2001 02:12:35 -0400
Received: from lenin.nu ([192.31.21.154]:37906 "HELO lenin.nu")
	by vger.kernel.org with SMTP id <S265345AbRFVGMY>;
	Fri, 22 Jun 2001 02:12:24 -0400
Date: Thu, 21 Jun 2001 23:12:12 -0700
From: "Peter C. Norton" <spacey@lenin.nu>
To: Sander Steffann <steffann@nederland.net>
Cc: vlan@Scry.WANfear.com, linux-kernel@vger.kernel.org,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        "David S. Miller" <davem@redhat.com>, Lennert <buytenh@gnu.org>,
        Gleb Natapov <gleb@nbase.co.il>
Subject: Re: [VLAN] Should VLANs be devices or something else?
Message-ID: <20010621231212.A20200@lenin.nu>
In-Reply-To: <Pine.LNX.4.30.0106191016200.27487-100000@talentix.dwd.de> <3B2FCE0C.67715139@candelatech.com> <004b01c0f959$af9d96c0$8e01a8c0@OFFICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <004b01c0f959$af9d96c0$8e01a8c0@OFFICE>; from steffann@nederland.net on Wed, Jun 20, 2001 at 09:21:55AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with the device vote.  Also, if the interface to the vlan devices
are similar enough to ethernet that the bonding driver can easily
incorperate them, then you can get bonded (a.k.a. redundant) trunks for
cheap.  This would lead to linux becoming a more robust router in practice.

-Peter

On Wed, Jun 20, 2001 at 09:21:55AM +0200, Sander Steffann wrote:
> Hi Ben & all,
> 
> > Should VLANs be devices or some other thing?
> 
> VLANs should be devices IMHO. It 'feels' right, and I think it's what most
> (if not all) users expect them to be.
> 
> Bye,
> Sander.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
The 5 year plan:
In five years we'll make up another plan.
Or just re-use this one.
